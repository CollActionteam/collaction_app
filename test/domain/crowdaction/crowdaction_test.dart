import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/domain/crowdaction/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_utilities.dart';
import 'crowdaction_test_fixtures.dart';

void main() {
  group('Testing Crowdaction DTO', () {
    test('Testing hasParticipants getter', () {
      expect(noParticipantCA.hasParticipants, false);
      expect(participantCA.hasParticipants, true);
      expect(passwordCA.hasParticipants, true);
      expect(noParticipantPwdCrowdactions.hasParticipants, false);
    });

    test('Testing hasPassword getter', () {
      expect(noParticipantCA.hasPassword, false);
      expect(participantCA.hasPassword, false);
      expect(passwordCA.hasPassword, true);
      expect(noParticipantPwdCrowdactions.hasPassword, true);
    });

    test('Testing CrowdAction.toChips() method', () {
      // tests for CrowdAction without subCategory
      expect(participantCA.toChips().length, 1);
      expect(participantCA.category, 'tCategory');
      expect(participantCA.subcategory, null);

      // tests for CrowdActions with SubCategory
      final tCA = participantCA.copyWith(subcategory: 'tSubCategory');
      expect(tCA.toChips().length, 2);
      expect(tCA.category, 'tCategory');
      expect(tCA.subcategory, 'tSubCategory');
    });
    // test('Testing CrowdAction.avatarWidth() method', () {
    //   expect(noParticipantCA.avatarWidth(), 40);
    //   expect(participantCA.avatarWidth(), 80);
    //   final tCA = generateDummyCrowdaction(participantCnt: 5);
    //   expect(tCA.avatarWidth(), 100);
    // });

    test('Testing CrowdAction.isOpen() method', () {
      final DateTime now = DateTime.now();

      final CrowdAction tAfterCrowdAction = generateDummyCrowdaction(
        dateLimitJoin: now.subtract(const Duration(days: 15)),
        endDate: now.subtract(
          const Duration(days: 10),
        ),
      );

      final CrowdAction tAfterCrowdAction2 = generateDummyCrowdaction(
        dateLimitJoin: now.subtract(
          const Duration(days: 15),
        ),
        endDate: now.add(
          const Duration(days: 10),
        ),
      );

      final CrowdAction tBeforeEndCrowdAction = generateDummyCrowdaction(
        dateLimitJoin: now.add(
          const Duration(days: 3),
        ),
        endDate: now.add(
          const Duration(days: 10),
        ),
      );

      final CrowdAction tBeforeEndCrowdAction2 = generateDummyCrowdaction(
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

  test('Testing CommitmentOptions.idToIcon() method', () {
    crowdActionCommitmentIcons.forEach((key, value) {
      expect(tCommitmentOption.copyWith(id: key).icon, value);
    });
  });
}
