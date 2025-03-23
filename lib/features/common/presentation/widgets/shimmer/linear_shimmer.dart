import 'package:flutter/material.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/shimmer/shimmer_loading.dart';

class LinearShimmer extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsets padding;
  final Color color;
  final int totalItems;
  final double listItemGap;
  final double lineGap;
  final BorderRadius borderRadius;

  const LinearShimmer({
    super.key,
    this.width = double.infinity,
    this.height = 24.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    this.color = Colors.black,
    this.totalItems = 5,
    this.listItemGap = 16.0,
    this.lineGap = 16.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });

  List<Widget> items() {
    List<Widget> items = [];
    for (var i = 0; i < totalItems; i++) {
      items.add(ShimmerLoading(
          isLoading: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: borderRadius,
                ),
              ),
            ],
          )));
      items.add(SizedBox(height: listItemGap));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items(),
      ),
    );
  }
}
