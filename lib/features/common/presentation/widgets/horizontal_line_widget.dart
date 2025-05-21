import 'package:flutter/material.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/app_colors.dart';

class HorizontalLineWidget extends StatelessWidget {
  const HorizontalLineWidget({
    super.key,
    this.margin,
  });

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: AppColors.neutral90,
          ),
        ),
      ),
    );
  }
}
