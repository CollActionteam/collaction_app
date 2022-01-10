import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../themes/constants.dart';

class ImageSkeletonLoader extends StatelessWidget {
  final double height;

  const ImageSkeletonLoader({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kSecondaryTransparent,
      highlightColor: kAlmostTransparent,
      child: Container(
        height: height,
        color: kSecondaryTransparent,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
