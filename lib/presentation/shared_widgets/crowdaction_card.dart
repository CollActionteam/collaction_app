import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/crowdaction/crowdaction.dart';
import '../core/collaction_icons.dart';
import '../home/widgets/password_modal.dart';
import '../routes/app_routes.gr.dart';
import '../themes/constants.dart';
import 'custom_fab.dart';

class CrowdActionCard extends StatelessWidget {
  final CrowdAction crowdAction;
  final double scaleFactor;
  final Function()? onTap;

  const CrowdActionCard({
    Key? key,
    required this.crowdAction,
    this.scaleFactor = 1.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            if (crowdAction.hasPassword) {
              showPasswordModal(context, crowdAction);
            } else {
              context.router.push(
                CrowdActionDetailsRoute(crowdAction: crowdAction),
              );
            }
          },
      child: Container(
        margin: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
              color: kShadowColor,
              blurRadius: 4.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          height: 395 * scaleFactor,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: kSecondaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 216 * scaleFactor,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      crowdAction.images.card,
                    ),
                  ),
                ),
                child: crowdAction.hasPassword
                    ? Stack(
                        children: const [
                          Positioned(
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
                          )
                        ],
                      )
                    : null,
              ),
              const SizedBox(height: 5.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 15.0),
                        Wrap(
                          spacing: 12.0,
                          children: crowdAction.toChips(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Text(
                          crowdAction.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 22.0 * scaleFactor,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      crowdAction.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: kInactiveColor),
                    ),
                  ),
                  // TODO: Implement after MVP
                  //   if (_someParticipants()) ...[
                  //     const SizedBox(
                  //       height: 20,
                  //     ),
                  //     Container(
                  //       height: 40,
                  //       margin: const EdgeInsets.symmetric(horizontal: 20),
                  //       child: Row(
                  //         children: [
                  //           SizedBox(
                  //             width: crowdAction.avatarWidth(),
                  //             child: ParticipantAvatars(
                  //               participants: crowdAction.topParticipants,
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             width: 20,
                  //           ),
                  //           Expanded(
                  //             child: Text(
                  //               "Join ${crowdAction.topParticipants.title(crowdAction.participantCount)}",
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .caption
                  //                   ?.copyWith(fontSize: 12),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
