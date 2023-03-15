import 'package:collaction_app/domain/core/location.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction.dart';

import '../../test_utilities.dart';

final List<CommitmentOption> tListCommitmentOptions = [tCommitmentOption];

const Images tImage = Images(card: 'tCard', banner: 'tBanner');

const Location tLocation = Location(code: 'tCode', name: 'tName');

CrowdAction generateDummyCrowdaction({
  int participantCnt = 0,
  bool password = false,
  DateTime? endDate,
  JoinStatus? joinStatus,
}) {
  return CrowdAction(
    id: 'tID',
    type: 'tType',
    title: 'tTitle',
    description: 'tDescription',
    category: 'tCategory',
    location: tLocation,
    commitmentOptions: tListCommitmentOptions,
    endAt: endDate ?? DateTime(2022, 1, 31),
    images: tImage,
    participantCount: participantCnt,
    status: Status.started,
    joinStatus: joinStatus ?? JoinStatus.open,
    password: password ? 'testPwd' : null,
  );
}

// when no participants, no password
final CrowdAction noParticipantCA = generateDummyCrowdaction();

// when no password but participants > 0
final CrowdAction participantCA = generateDummyCrowdaction(
  participantCnt: 2,
);

// when participant > 0 for private crowdaction
final CrowdAction passwordCA = generateDummyCrowdaction(
  participantCnt: 2,
  password: true,
);

// no participant but private crowdaction
final CrowdAction noParticipantPwdCrowdactions = generateDummyCrowdaction(
  password: true,
);
