import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  List<TopParticipant> generateTopParticipants(int num) {
    late int topParticipantCnt;
    if (num < 3) {
      topParticipantCnt = num;
    } else {
      topParticipantCnt = 3;
    }
    return List.generate(
      topParticipantCnt,
      (i) => TopParticipant(userId: 'tUser$i', name: 'tName$i'),
    );
  }

  final List<CommitmentOption> tCommitmentOptions = [
    CommitmentOption(
      id: 'no-beef',
      label: 'tLabel',
      description: 'tDescription',
    ),
  ];

  const Images tImage = Images(card: 'tCard', banner: 'tBanner');

  CrowdAction generatingCrowdactions({
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
      commitmentOptions: tCommitmentOptions,
      dateStart: DateTime(2022, 1, 2),
      dateEnd: endDate ?? DateTime(2022, 1, 31),
      dateLimitJoin: dateLimitJoin ?? DateTime(2022, 1, 10),
      images: tImage,
      participantCount: participantCnt,
      passwordJoin: password ? 'testPwd' : null,
    );
  }

  group('Testing Crowdaction DTO', () {
    late CrowdAction noParticipantCA;
    late CrowdAction participantCA;
    late CrowdAction passwordCA;
    late CrowdAction noParticipantPwdCrowdactions;

    setUp(() {
      // when no participants, no password
      noParticipantCA = generatingCrowdactions();

      // when no password but participants > 0
      participantCA = generatingCrowdactions(
        participantCnt: 2,
      );

      // when participant > 0 for private crowdaction
      passwordCA = generatingCrowdactions(
        participantCnt: 2,
        password: true,
      );

      // no participant but private crowdaction
      noParticipantPwdCrowdactions = generatingCrowdactions(
        password: true,
      );
    });

    test('testing hasParticipants getter', () {
      expect(noParticipantCA.hasParticipants, false);
      expect(participantCA.hasParticipants, true);
      expect(passwordCA.hasParticipants, true);
      expect(noParticipantPwdCrowdactions.hasParticipants, false);
    });

    test('testing hasPassword getter', () {
      expect(noParticipantCA.hasPassword, false);
      expect(participantCA.hasPassword, false);
      expect(passwordCA.hasPassword, true);
      expect(noParticipantPwdCrowdactions.hasPassword, true);
    });

    test('testing CrowdAction.toChips() method', () {
      // tests for CrowdAction without subCategory
      expect(participantCA.toChips().length, 1);
      expect(participantCA.category, 'tCategory');
      expect(participantCA.subCategory, null);

      // tests for CrowdActions with SubCategory
      final tCA = participantCA.copyWith(subCategory: 'tSubCategory');
      expect(tCA.toChips().length, 2);
      expect(tCA.category, 'tCategory');
      expect(tCA.subCategory, 'tSubCategory');
    });
    test('testing CrowdAction.avatarWidth() method', () {
      expect(noParticipantCA.avatarWidth(), 40);
      expect(participantCA.avatarWidth(), 80);
      final tCA = generatingCrowdactions(participantCnt: 5);
      expect(tCA.avatarWidth(), 100);
    });

    test('testing CrowdAction.isOpen() method', () {
      final DateTime now = DateTime.now();

      final CrowdAction tAfterCrowdAction = generatingCrowdactions(
        dateLimitJoin: now.subtract(const Duration(days: 15)),
        endDate: now.subtract(
          const Duration(days: 10),
        ),
      );

      final CrowdAction tAfterCrowdAction2 = generatingCrowdactions(
        dateLimitJoin: now.subtract(
          const Duration(days: 15),
        ),
        endDate: now.add(
          const Duration(days: 10),
        ),
      );

      final CrowdAction tBeforeEndCrowdAction = generatingCrowdactions(
        dateLimitJoin: now.add(
          const Duration(days: 3),
        ),
        endDate: now.add(
          const Duration(days: 10),
        ),
      );

      final CrowdAction tBeforeEndCrowdAction2 = generatingCrowdactions(
        dateLimitJoin: now.add(
          const Duration(days: 3),
        ),
        endDate: now.subtract(
          const Duration(days: 10),
        ),
      );

      expect(tBeforeEndCrowdAction.isOpen, true);
      expect(tBeforeEndCrowdAction2.isOpen, false);
      expect(tAfterCrowdAction.isOpen, false);
      expect(tAfterCrowdAction2.isOpen, false);
    });
  });
}
