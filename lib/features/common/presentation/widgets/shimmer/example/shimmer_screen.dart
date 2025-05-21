import 'package:flutter/material.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/shimmer/circular_shimmer.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/shimmer/linear_shimmer.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/shimmer/rectangular_shimmer.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/shimmer/shimmer.dart';

class ShimmerScreen extends StatefulWidget {
  const ShimmerScreen({
    super.key,
  });

  @override
  State<ShimmerScreen> createState() => _ShimmerScreenState();
}

class _ShimmerScreenState extends State<ShimmerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer(
        child: ListView(
          children: const [
            SizedBox(height: 16),
            CircularShimmer(
              totalItems: 5,
            ),
            LinearShimmer(
              totalItems: 5,
            ),
            SizedBox(height: 16),
            RectangularShimmer(
              totalItems: 3,
              listItemGap: 50,
            ),
            SizedBox(height: 16),
            LinearShimmer(
              totalItems: 1,
            ),
          ],
        ),
      ),
    );
  }
}
