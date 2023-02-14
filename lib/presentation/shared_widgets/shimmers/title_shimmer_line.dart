import 'package:flutter/material.dart';

import '../../../core/core.dart';

class TitleShimmerLine extends StatelessWidget {
  final double width;
  final double height;

  const TitleShimmerLine({
    required this.width,
    this.height = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.colors.secondaryTransparent,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
