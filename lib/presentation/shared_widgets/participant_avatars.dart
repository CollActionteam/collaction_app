import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/crowdaction/crowdaction.dart';

class ParticipantAvatars extends StatelessWidget {
  final List<TopParticipant> participants;

  const ParticipantAvatars({
    Key? key,
    required this.participants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: participants
          .take(3)
          .toList()
          .asMap()
          .entries
          .map(
            (participant) => _createAvatar(participant.value, participant.key),
          )
          .toList(),
    );
  }

  Align _createAvatar(TopParticipant participant, int index) {
    return Align(
      alignment: _getIndexAlignment(index),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: participant.imageUrl != null
            ? CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey[300],
                backgroundImage: CachedNetworkImageProvider(
                  participant.imageUrl!,
                ), // Provide your custom image
              )
            : Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
      ),
    );
  }

  Alignment _getIndexAlignment(int index) {
    switch (index) {
      case 0:
        return Alignment.centerLeft;
      case 1:
        return Alignment.center;
      default:
        return Alignment.centerRight;
    }
  }
}
