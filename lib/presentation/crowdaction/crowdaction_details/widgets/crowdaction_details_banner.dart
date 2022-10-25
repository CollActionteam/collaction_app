import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collaction_app/core/core.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/presentation/core/collaction_icons.dart';
import 'package:collaction_app/presentation/shared_widgets/custom_fab.dart';
import 'package:collaction_app/presentation/shared_widgets/image_skeleton_loader.dart';
import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CrowdActionDetailsBanner extends StatelessWidget {
  const CrowdActionDetailsBanner({
    super.key,
    required this.crowdAction,
  });

  final CrowdAction? crowdAction;

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
                onTap: () => context.router.pop(),
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
                      imageUrl: NetworkConfig.crowdActionBanner(crowdAction),
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
            if (crowdAction?.hasPassword ?? false) ...[
              const Positioned(
                bottom: 10,
                right: 10,
                child: CustomFAB(
                  heroTag: 'locked',
                  isMini: true,
                  color: kSecondaryColor,
                  child: Icon(
                    CollactionIcons.lock,
                    color: kPrimaryColor300,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
