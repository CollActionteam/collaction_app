import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/crowdaction/crowdaction.dart';
import '../home/widgets/password_modal.dart';
import '../routes/app_routes.gr.dart';
import '../themes/constants.dart';
import 'accent_chip.dart';

class MicroCrowdActionCard extends StatelessWidget {
  final CrowdAction crowdAction;

  const MicroCrowdActionCard(this.crowdAction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (crowdAction.usesPassword) {
          showPasswordModal(context, crowdAction);
        } else {
          context.router.push(
            CrowdActionDetailsRoute(crowdAction: crowdAction),
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
                    image: CachedNetworkImageProvider(crowdAction.images.card),
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
                      if (crowdAction.dateLimitJoin.compareTo(DateTime.now()) >=
                          0)
                        const AccentChip(
                          text: "Sign up now",
                          leading: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
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
