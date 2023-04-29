import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../themes/constants.dart';

class MicroCrowdActionCardLoading extends StatelessWidget {
  const MicroCrowdActionCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black.withOpacity(0.1),
      highlightColor: Colors.white.withOpacity(0.2),
      child: MicroCrowdactionSkeleton(),
    );
  }
}

class MicroCrowdactionSkeleton extends StatelessWidget {
  final Color? color;
  const MicroCrowdactionSkeleton({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 148,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color ?? kPrimaryColor0)),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: color ?? kPrimaryColor0,
            ),
            margin: const EdgeInsets.only(left: 10),
            height: 128,
            width: 100,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    decoration: BoxDecoration(
                      color: color ?? kPrimaryColor0,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    height: 35,
                    width: MediaQuery.of(context).size.width * .25,
                  ),
                  ...List.generate(
                    2,
                    (index) => Container(
                      margin: const EdgeInsets.only(top: 6),
                      decoration: BoxDecoration(
                          color: color ?? kPrimaryColor0,
                          borderRadius: BorderRadius.circular(8)),
                      height: 20,
                      width: MediaQuery.of(context).size.width * .6,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                        color: color ?? kPrimaryColor0,
                        borderRadius: BorderRadius.circular(8)),
                    height: 20,
                    width: MediaQuery.of(context).size.width * .2,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
