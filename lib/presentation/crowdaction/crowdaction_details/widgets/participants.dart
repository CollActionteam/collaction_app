import 'package:collaction_app/presentation/crowdaction/crowdaction_details/widgets/participation_count_text.dart';
import 'package:flutter/material.dart';

import '../../../../domain/crowdaction/crowdaction.dart';
import '../../../shared_widgets/participant_avatars.dart';

class Participants extends StatelessWidget {
  final CrowdAction? crowdAction;

  const Participants({
    super.key,
    this.crowdAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (crowdAction != null &&
            (crowdAction?.participantCount ?? 0) > 0) ...[
          TopParticipantAvatars(
            crowdActionId: crowdAction!.id,
          ),
          const SizedBox(
            width: 20,
          ),
        ],
        Flexible(
          child: ParticipationCountText(
            crowdAction: crowdAction,
            isEnded: crowdAction?.isClosed ?? false,
          ),
        ),
      ],
    );
  }
}
