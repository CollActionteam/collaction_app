import 'package:flutter/cupertino.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../../infrastructure/crowdaction/crowdaction_dto.dart';
import '../../shared_widgets/secondary_chip.dart';

extension CrowdActionX on CrowdAction {
  List<Widget> toChips() {
    return [
      SecondaryChip(text: category),
      if (subCategory != null) ...[SecondaryChip(text: subCategory ?? "")],
    ];
  }
}

extension ParticipantsX on List<TopParticipant>? {
  double avatarWidth() {
    if (this?.length == 3) {
      return 100.0;
    } else if (this?.length == 2) {
      return 80.0;
    } else {
      return 40.0;
    }
  }
}
