import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/crowdaction/crowdaction.dart';
import '../home/widgets/password_modal.dart';

import '../routes/app_routes.dart';
import '../themes/constants.dart';
import 'accent_chip.dart';
import 'country_icon.dart';
import 'micro_lock.dart';

class MicroCrowdActionCard extends StatelessWidget {
  final CrowdAction crowdAction;

  const MicroCrowdActionCard(
    this.crowdAction, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          if (crowdAction.hasPassword) {
            PasswordModal.show(context, crowdAction);
          } else {
            context.push(AppPage.crowdActionDetailsRoute(crowdAction.id));
          }
        },
        child: SizedBox(
          height: 148,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      crowdAction.cardUrl,
                      errorListener: () {},
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                margin: const EdgeInsets.only(left: 10),
                height: 128,
                width: 100,
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AccentChip(
                            text: crowdAction.statusChipLabel,
                            color: crowdAction.isOpen || crowdAction.isWaiting
                                ? kAccentColor
                                : kPrimaryColor200,
                            leading: Icon(
                              crowdAction.isOpen || crowdAction.isWaiting
                                  ? Icons.check
                                  : Icons.close,
                              color: Colors.white,
                            ),
                            noMaterialTapTargetSize: true,
                          ),
                          ...[
                            const SizedBox(width: 10),
                            CountryIcon(
                                countryCode: crowdAction.location.code,
                                radius: 15),
                          ],
                          if (crowdAction.hasPassword) ...[
                            const SizedBox(width: 10),
                            const MicroLock(),
                          ],
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          crowdAction.title,
                          softWrap: false,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 10),
                        child: Text(
                          crowdAction.description,
                          softWrap: false,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: kInactiveColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
