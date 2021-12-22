import 'package:flutter/material.dart';

import '../../domain/crowdaction/crowdaction.dart';
import '../../domain/crowdaction/participant.dart';
import '../crowd_action/utils/crowd_action.ext.dart';
import '../themes/constants.dart';
import 'participant_avatars.dart';

class CrowdActionCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final List<Widget> chips;
  final String? description;
  final double scaleFactor;
  final List<TopParticipant>? participants;
  final int? totalParticipants;
  final Function()? onTap;

  const CrowdActionCard({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.chips,
    this.description,
    this.scaleFactor = 1.0,
    this.participants,
    this.totalParticipants,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                    image: NetworkImage(imagePath),
                  ),
                ),
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
                          children: chips,
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
                          title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 22.0 * scaleFactor,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor400),
                        ),
                      ],
                    ),
                  ),
                  if (description != null) ...[
                    const SizedBox(height: 18.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: kInactiveColor),
                      ),
                    ),
                  ],
                  // TODO: Add participants widget
                  if (_someParticipants()) ...[
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          SizedBox(
                            width: participants?.avatarWidth(),
                            child: ParticipantAvatars(
                              participants: participants ?? [],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: Text(
                            "Join ${participants?.title(totalParticipants ?? 0) ?? ""}",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(fontSize: 12),
                          ))
                        ],
                      ),
                    ),
                  ],
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

  bool _someParticipants() =>
      totalParticipants != null &&
      participants != null &&
      participants?.isNotEmpty == true;
}
