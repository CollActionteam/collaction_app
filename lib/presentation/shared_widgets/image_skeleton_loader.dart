import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../themes/constants.dart';

class ImageSkeletonLoader extends StatelessWidget {
  final double height;
  final bool isCircle;

  const ImageSkeletonLoader({
    super.key,
    required this.height,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kSecondaryTransparent,
      highlightColor: kAlmostTransparent,
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: kSecondaryTransparent,
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }
}
