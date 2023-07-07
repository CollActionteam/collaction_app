import 'package:flutter/material.dart';

import '../../themes/constants.dart';

class TitleShimmerLine extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;

  const TitleShimmerLine({
    required this.width,
    this.height = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? kSecondaryTransparent,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
