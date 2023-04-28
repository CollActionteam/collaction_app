import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../themes/constants.dart';
import 'title_shimmer_line.dart';

class CommitmentCardShimmer extends StatelessWidget {
  const CommitmentCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: kSecondaryColor,
        border: Border.all(color: kPrimaryColor0),
      ),
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: kSecondaryColor,
            ),
            alignment: Alignment.center,
            child: Shimmer.fromColors(
              baseColor: kPrimaryColor0,
              highlightColor: kAlmostTransparent,
              child: const CircleAvatar(
                radius: 75 / 2,
              ),
            ),
          ),
          const Spacer(),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            constraints: const BoxConstraints(
              maxHeight: 70,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: kPrimaryColor0,
                  highlightColor: Colors.white.withOpacity(0.2),
                  child: TitleShimmerLine(
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                ),
                const SizedBox(height: 5),
                Shimmer.fromColors(
                  baseColor: kPrimaryColor0,
                  highlightColor: Colors.white.withOpacity(0.2),
                  child: TitleShimmerLine(
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const SizedBox(height: 32, width: 32),
        ],
      ),
    );
  }
}
