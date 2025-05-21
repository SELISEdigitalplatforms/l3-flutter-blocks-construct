import 'package:flutter/material.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/shimmer/rectangular_shimmer.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/shimmer/shimmer.dart';

class GeneralInfoSectionShimmerWidget extends StatelessWidget {
  final double? height;

  const GeneralInfoSectionShimmerWidget({
    super.key,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RectangularShimmer(
            totalItems: 1,
            height: height ?? 180,
            listItemGap: 0,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
        ],
      ),
    );
  }
}
