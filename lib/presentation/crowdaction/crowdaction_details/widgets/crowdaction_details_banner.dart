
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/core.dart';
import '../../../../domain/crowdaction/crowdaction.dart';
import '../../../core/collaction_icons.dart';
import '../../../shared_widgets/country_icon.dart';
import '../../../shared_widgets/custom_fab.dart';
import '../../../shared_widgets/image_skeleton_loader.dart';
import '../../../themes/constants.dart';

class CrowdActionDetailsBanner extends StatelessWidget {
  final CrowdAction? crowdAction;

  const CrowdActionDetailsBanner({
    super.key,
    required this.crowdAction,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 310,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          SizedBox(
            width: 39,
            height: 39,
            child: Material(
              type: MaterialType.button,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              elevation: 4,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: context.pop,
                child: const Icon(
                  CollactionIcons.left,
                  color: kPrimaryColor400,
                ),
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: crowdAction != null
                  ? CachedNetworkImage(
                      imageUrl: crowdAction?.bannerUrl ?? nullStaticUrl,
                      placeholder: (context, url) => const ImageSkeletonLoader(
                        height: 310,
                      ),
                      errorWidget: (context, url, error) =>
                          const ImageSkeletonLoader(
                        height: 310,
                      ),
                      fit: BoxFit.cover,
                    )
                  : Shimmer.fromColors(
                      baseColor: Colors.black.withOpacity(0.1),
                      highlightColor: Colors.white.withOpacity(0.2),
                      child: const ImageSkeletonLoader(
                        height: 310,
                      ),
                    ),
            ),
            Positioned(
                bottom: 10,
                right: 10,
                child: Row(
                  children: [
                    if (crowdAction?.hasPassword ?? false) ...[
                      CustomFAB(
                        heroTag: 'locked',
                        isMini: true,
                        color: kSecondaryColor,
                        child: Icon(
                          CollactionIcons.lock,
                          color: kPrimaryColor300,
                        ),
                      ),
                    ],
                    if ((crowdAction?.hasPassword ?? false) &&
                        (crowdAction?.location != null)) ...[
                      const SizedBox(width: 6),
                    ],
                    if (crowdAction?.location != null) ...[
                      CountryIcon(
                        countryCode: crowdAction?.location.code ?? 'nl',
                        radius: 20,
                      ),
                    ],
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
