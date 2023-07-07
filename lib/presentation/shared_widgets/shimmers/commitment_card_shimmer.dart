import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../themes/constants.dart';
import 'title_shimmer_line.dart';

class CommitmentCardShimmer extends StatelessWidget {
  const CommitmentCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kPrimaryColor0,
      highlightColor: kAlmostTransparent,
      child: CommitmentCardSkeleton(),
    );
  }
}

class CommitmentCardSkeleton extends StatelessWidget {
  final Color? color;
  const CommitmentCardSkeleton({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: color ?? kPrimaryColor0),
      ),
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color ?? kPrimaryColor0,
            ),
            alignment: Alignment.center,
            child: const CircleAvatar(
              radius: 65 / 2,
              backgroundColor: kPrimaryColor0,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            constraints: const BoxConstraints(
              maxHeight: 70,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleShimmerLine(
                  color: color ?? kPrimaryColor0,
                  width: MediaQuery.of(context).size.width * .4,
                ),
                const SizedBox(height: 5),
                TitleShimmerLine(
                  color: color ?? kPrimaryColor0,
                  width: MediaQuery.of(context).size.width * .5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
