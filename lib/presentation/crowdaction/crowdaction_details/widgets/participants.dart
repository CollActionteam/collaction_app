import 'package:flutter/material.dart';

import '../../../../domain/crowdaction/crowdaction.dart';
import '../../../shared_widgets/participant_avatars.dart';
import '../../crowdaction_participants/crowdaction_participants_screen.dart';
import 'participation_count_text.dart';

class Participants extends StatelessWidget {
  final CrowdAction? crowdAction;

  const Participants({
    super.key,
    this.crowdAction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CrowdActionParticipantsPage(
            crowdActionId: crowdAction!.id,
          ),
        ),
      ),
      child: Row(
        children: [
          if (crowdAction != null &&
              (crowdAction?.participantCount ?? 0) > 0) ...[
            TopParticipantAvatars(
              crowdActionId: crowdAction!.id,
            ),
            const SizedBox(width: 15),
          ],
          Flexible(
            child: ParticipationCountText(
              crowdAction: crowdAction,
              isEnded: crowdAction?.isClosed ?? false,
            ),
          ),
        ],
      ),
    );
  }
}
