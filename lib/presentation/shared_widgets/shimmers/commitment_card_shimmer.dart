import 'package:collaction_app/presentation/core/collaction_icons.dart';
import 'package:collaction_app/presentation/shared_widgets/shimmers/title_shimmer_line.dart';
import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(10.0),
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
              baseColor: kSecondaryTransparent,
              highlightColor: kAlmostTransparent,
              child: const Icon(
                CollactionIcons.commitment,
                color: kPrimaryColor0,
                size: 30,
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
                  baseColor: Colors.black.withOpacity(0.1),
                  highlightColor: Colors.white.withOpacity(0.2),
                  child: TitleShimmerLine(
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                ),
                const SizedBox(height: 5),
                Shimmer.fromColors(
                  baseColor: Colors.black.withOpacity(0.1),
                  highlightColor: Colors.white.withOpacity(0.2),
                  child: TitleShimmerLine(
                    height: 18,
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
