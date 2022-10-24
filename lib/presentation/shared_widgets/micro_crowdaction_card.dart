import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

import '../../domain/crowdaction/crowdaction.dart';
import '../core/routes/app_page.dart';
import '../home/widgets/password_modal.dart';
import '../themes/constants.dart';
import 'accent_chip.dart';
import 'micro_lock.dart';

class MicroCrowdActionCard extends StatelessWidget {
  final CrowdAction crowdAction;

  const MicroCrowdActionCard(
    this.crowdAction, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (crowdAction.hasPassword) {
          showPasswordModal(context, crowdAction);
        } else {
          // TODO: Use ID & extras
          context.push(
            AppPage.crowdActionDetails.toPath,
            extra: <String, Object?>{
              'crowdAction': crowdAction,
            },
          );
        }
      },
      child: Container(
        height: 148,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 4,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      '${dotenv.get('BASE_STATIC_ENDPOINT_URL')}/${crowdAction.images.card}',
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AccentChip(
                            text: crowdAction.isOpen
                                ? "Now open"
                                : (crowdAction.isEnded
                                    ? "Finished"
                                    : "Currently running"),
                            color: crowdAction.isOpen
                                ? kAccentColor
                                : kPrimaryColor200,
                            leading: Icon(
                              crowdAction.isOpen ? Icons.check : Icons.close,
                              color: Colors.white,
                            ),
                          ),
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
