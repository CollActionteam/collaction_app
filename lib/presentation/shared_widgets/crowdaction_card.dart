import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
// ignore: depend_on_referenced_packages
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:flutter/material.dart';

import '../../domain/crowdaction/crowdaction.dart';
import '../core/collaction_icons.dart';
import '../crowdaction/crowdaction_details/widgets/participants.dart';
import '../home/widgets/password_modal.dart';
import '../routes/app_routes.gr.dart';
import '../themes/constants.dart';
import 'country_icon.dart';
import 'custom_fab.dart';

class CrowdActionCard extends StatefulWidget {
  final CrowdAction crowdAction;
  final Function()? onTap;

  const CrowdActionCard({
    super.key,
    required this.crowdAction,
    this.onTap,
  });

  @override
  State<CrowdActionCard> createState() => _CrowdActionCardState();
}

class _CrowdActionCardState extends State<CrowdActionCard>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      margin: const EdgeInsets.all(12.0),
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        color: kSecondaryColor,
        elevation: 4,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: widget.onTap ??
              () {
                if (widget.crowdAction.hasPassword) {
                  PasswordModal.show(context, widget.crowdAction);
                } else {
                  context.router.push(
                    CrowdActionDetailsRoute(crowdAction: widget.crowdAction),
                  );
                }
              },
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 215,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          widget.crowdAction.cardUrl,
                          imageRenderMethodForWeb:
                              ImageRenderMethodForWeb.HttpGet,
                          errorListener: () {},
                        ),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Wrap(spacing: 10, children: [
                            if (widget.crowdAction.hasPassword)
                              CustomFAB(
                                heroTag: 'locked',
                                isMini: true,
                                color: kSecondaryColor,
                                child: Icon(
                                  CollactionIcons.lock,
                                  color: kPrimaryColor300,
                                ),
                                elevation: 0,
                              ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: CountryIcon(
                                countryCode: widget.crowdAction.location.code,
                                radius: 20,
                              ),
                            )
                          ]),
                        )
                      ],
                    )),
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
                            children: widget.crowdAction.toChips(),
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
                            widget.crowdAction.title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 22.0,
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
                        widget.crowdAction.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: kInactiveColor),
                      ),
                    ),
                    if (widget.crowdAction.participantCount > 0) ...[
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Participants(crowdAction: widget.crowdAction),
                      ),
                    ],
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
