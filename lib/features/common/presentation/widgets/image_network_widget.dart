import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/logger/app_logging.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/asset_helper.dart';

class ImageNetworkWidget extends StatefulWidget {
  final String imageUrl;
  final Widget? exceptionUi;
  final String? exceptionMessage;
  final Widget? loadingUi;

  final double? width;
  final double? height;
  final Color? color;
  final Animation<double>? opacity;
  final BlendMode? colorBlendMode;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final Rect? centerSlice;
  final bool matchTextDirection;
  final bool gaplessPlayback;
  final FilterQuality filterQuality;
  final bool isAntiAlias;
  final ImageFrameBuilder? frameBuilder;
  final String? semanticLabel;
  final bool excludeFromSemantics;
  final int maxRetries;
  final Duration retryDelay;

  const ImageNetworkWidget(
    this.imageUrl, {
    this.exceptionUi,
    this.exceptionMessage,
    this.loadingUi,
    double scale = 1.0,
    this.frameBuilder,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.color,
    this.opacity,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.filterQuality = FilterQuality.medium,
    this.isAntiAlias = false,
    Map<String, String>? headers,
    int? cacheWidth,
    int? cacheHeight,
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
    super.key,
  });

  @override
  State<ImageNetworkWidget> createState() => _ImageNetworkWidgetState();
}

class _ImageNetworkWidgetState extends State<ImageNetworkWidget> {
  bool isLoading = true;
  ImageProvider? _imageProvider;
  int _retryCount = 0;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void didUpdateWidget(ImageNetworkWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      _retryCount = 0;
      _hasError = false;
      _loadImage();
    }
  }

  Future<void> _loadImage() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (widget.imageUrl.startsWith('data:image')) {
        final String base64String = widget.imageUrl.split(',').last;
        final Uint8List bytes = base64Decode(base64String);
        _imageProvider = MemoryImage(bytes);
      } else {
        _imageProvider = NetworkImage(widget.imageUrl);
      }

      await precacheImage(_imageProvider!, context).then((_) {
        setState(() {
          isLoading = false;
          _hasError = false;
          _retryCount = 0;
        });
      }).catchError((error) {
        logger.e(message: 'Error loading image: $error, retryCount: $_retryCount', error: error);
        _retry(error);
      });
    } catch (e) {
      logger.e(message: 'Error decoding image: $e, retryCount: $_retryCount', error: e);
      _retry(e);
    }
  }

  void _retry(dynamic error) {
    if (_retryCount < widget.maxRetries) {
      _retryCount++;
      Future.delayed(widget.retryDelay, () {
        _loadImage();
      });
    } else {
      logger.e(message: 'Max retries reached for image: ${widget.imageUrl}', error: error);
      setState(() {
        isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return widget.loadingUi ??
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 30,
              height: MediaQuery.of(context).size.width / 30,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          );
    } else if (_hasError) {
      return widget.exceptionUi ?? Image.asset(AssetHelper.defaultProfile);
    } else if (_imageProvider == null) {
      return widget.exceptionUi ?? Image.asset(AssetHelper.defaultProfile);
    } else {
      return Image(
        image: _imageProvider!,
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
          logger.d(message: 'Failed to load the image inside Image widget: $error', stackTrace: stackTrace);
          return widget.exceptionUi ?? Image.asset(AssetHelper.defaultProfile);
        },
        width: widget.width,
        height: widget.height,
        color: widget.color,
        opacity: widget.opacity,
        colorBlendMode: widget.colorBlendMode,
        fit: widget.fit,
        alignment: widget.alignment,
        repeat: widget.repeat,
        centerSlice: widget.centerSlice,
        matchTextDirection: widget.matchTextDirection,
        gaplessPlayback: widget.gaplessPlayback,
        filterQuality: widget.filterQuality,
        isAntiAlias: widget.isAntiAlias,
        frameBuilder: widget.frameBuilder,
        semanticLabel: widget.semanticLabel,
        excludeFromSemantics: widget.excludeFromSemantics,
      );
    }
  }
}
