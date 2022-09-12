import 'package:collaction_app/presentation/shared_widgets/shimmers/title_shimmer_line.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CrowdActionTitle extends StatelessWidget {
  const CrowdActionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return title != null
        ? Text(
            title!,
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
          )
        : Shimmer.fromColors(
            baseColor: Colors.black.withOpacity(0.1),
            highlightColor: Colors.white.withOpacity(0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleShimmerLine(
                  width: MediaQuery.of(context).size.width,
                ),
                const SizedBox(height: 10),
                TitleShimmerLine(
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
              ],
            ),
          );
  }
}
