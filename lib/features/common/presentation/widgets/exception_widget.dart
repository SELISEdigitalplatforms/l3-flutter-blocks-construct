import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/no_data_found.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_routes.dart';

class ExceptionWidget extends StatelessWidget {
  final Widget? child;
  final String? title;
  final String? description;
  final bool hasButton;
  final String? buttonTextMessage;
  final Color? fontColor;
  final bool? isExceptionForImage;
  final double? imageExceptionIconSize;
  final EdgeInsetsGeometry? parentPadding;
  final Color? iconColor;

  const ExceptionWidget({
    super.key,
    this.child,
    this.title,
    this.description,
    this.hasButton = false,
    this.buttonTextMessage,
    this.fontColor,
    this.isExceptionForImage,
    this.imageExceptionIconSize,
    this.parentPadding,
    this.iconColor,
  });

  Widget _exceptionUi(
    BuildContext context, {
    Exception? exception,
  }) {
    final localizationsContext = AppLocalizations.of(context)!;
    return Padding(
      padding: parentPadding ?? const EdgeInsets.symmetric(horizontal: 20),
      child: NoDataFound(
        title: Text(
          title ?? localizationsContext.somethingWentWrong,
          style: fontColor == null
              ? Theme.of(context).textTheme.titleMedium
              : Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: fontColor,
                  ),
          textAlign: TextAlign.center,
        ),
        subtitle: Text(
          description ?? exception.toString(),
          style: fontColor == null
              ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.4,
                    fontWeight: FontWeight.w400,
                  )
              : Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.4,
                    fontWeight: FontWeight.w400,
                    color: fontColor,
                  ),
          textAlign: TextAlign.center,
        ),
        buttonTextMessage:
            buttonTextMessage ?? localizationsContext.gotoHome.toUpperCase(),
        onPressed: hasButton
            ? () {
                context.go(AppRoutes.home.path);
              }
            : null,
        iconSize: 32,
      ),
    );
  }

  Widget _exceptionUiForImageOnly(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Icon(
        Icons.broken_image_outlined,
        size: imageExceptionIconSize ?? 48,
        color: iconColor ?? Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (child == null) {
      if (isExceptionForImage == true) {
        return _exceptionUiForImageOnly(context);
      }
      return _exceptionUi(context);
    } else {
      try {
        return child!;
      } on Exception catch (exception) {
        return _exceptionUi(context, exception: exception);
      }
    }
  }
}
