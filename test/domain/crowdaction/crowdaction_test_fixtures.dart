import 'package:collaction_app/domain/crowdaction/crowdaction.dart';

List<TopParticipant> generateTopParticipants(int num) {
  final topParticipantCnt = num < 3 ? num : 3;
  return List.generate(
    topParticipantCnt,
    (i) => TopParticipant(userId: 'tUser$i', name: 'tName$i'),
  );
}

final tCommitmentOption = CommitmentOption(
  id: 'no-beef',
  label: 'tLabel',
  description: 'tDescription',
);

final List<CommitmentOption> tListCommitmentOptions = [tCommitmentOption];

const Images tImage = Images(card: 'tCard', banner: 'tBanner');

CrowdAction generateDummyCrowdaction({
  int participantCnt = 0,
  bool password = false,
  DateTime? endDate,
  DateTime? dateLimitJoin,
}) {
  return CrowdAction(
    crowdactionID: 'tID',
    title: 'tTitle',
    description: 'tDescription',
    category: 'tCategory',
    location: 'tLocation',
    topParticipants:
        participantCnt > 0 ? generateTopParticipants(participantCnt) : [],
    commitmentOptions: tListCommitmentOptions,
    dateStart: DateTime(2022, 1, 2),
    dateEnd: endDate ?? DateTime(2022, 1, 31),
    dateLimitJoin: dateLimitJoin ?? DateTime(2022, 1, 10),
    images: tImage,
    participantCount: participantCnt,
    passwordJoin: password ? 'testPwd' : null,
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
