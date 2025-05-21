import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/domain/constants/shimmer_gradient.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/theme_provider.dart';

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

class Shimmer extends ConsumerStatefulWidget {
  static ShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<ShimmerState>();
  }

  const Shimmer({
    super.key,
    this.linearGradient,
    this.child,
  });

  final LinearGradient? linearGradient;
  final Widget? child;

  @override
  ShimmerState createState() => ShimmerState();
}

class ShimmerState extends ConsumerState<Shimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  LinearGradient gradient() {
    LinearGradient? shimmerGradient = widget.linearGradient;
    if (shimmerGradient == null) {
      final themeMode = ref.watch(themeProvider);
      shimmerGradient = themeMode == ThemeMode.dark
          ? shimmerGradientDark
          : shimmerGradientLight;
    }
    return LinearGradient(
      colors: shimmerGradient.colors,
      stops: shimmerGradient.stops,
      begin: shimmerGradient.begin,
      end: shimmerGradient.end,
      transform:
          _SlidingGradientTransform(slidePercent: _shimmerController.value),
    );
  }

  bool get isSized =>
      (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  Size get size => (context.findRenderObject() as RenderBox).size;

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox?;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  Listenable get shimmerChanges => _shimmerController;

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}
