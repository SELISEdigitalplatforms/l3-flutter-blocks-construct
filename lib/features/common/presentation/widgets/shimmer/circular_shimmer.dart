import 'package:flutter/material.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/shimmer/shimmer_loading.dart';

class CircularShimmer extends StatelessWidget {
  final double containerHeight;
  final double width;
  final double height;
  final EdgeInsets padding;
  final BoxDecoration decoration;
  final int totalItems;
  final double gap;
  final Axis direction;

  const CircularShimmer({
    super.key,
    this.containerHeight = 72.0,
    this.width = 54.0,
    this.height = 54.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    this.decoration = const BoxDecoration(
      color: Colors.black,
      shape: BoxShape.circle,
    ),
    this.totalItems = 5,
    this.gap = 0.0,
    this.direction = Axis.horizontal,
  });

  List<Widget> items() {
    List<Widget> items = [];

    for (var i = 0; i < totalItems; i++) {
      items.add(ShimmerLoading(
          isLoading: true,
          child: Padding(
            padding: padding,
            child: Container(
              width: width,
              height: height,
              decoration: decoration,
              child: ClipOval(
                child: Image.network(
                  'https://docs.flutter.dev/cookbook/img-files/effects/split-check/Avatar1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )));
      items.add(SizedBox(width: gap));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: containerHeight,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: direction,
        shrinkWrap: true,
        children: items(),
      ),
    );
  }
}
