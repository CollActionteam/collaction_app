import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/core.dart';

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
      baseColor: context.colors.secondaryTransparent!,
      highlightColor: context.colors.almostTransparent!,
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: context.colors.secondaryTransparent,
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }
}
