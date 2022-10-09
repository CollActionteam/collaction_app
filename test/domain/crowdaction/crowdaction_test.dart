import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/domain/crowdaction/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_utilities.dart';
import 'crowdaction_test_fixtures.dart';

void main() {
  group('Testing Crowdaction class', () {
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

    test('Testing CrowdAction.isOpen() method', () {
      final tClosedCrowdAction = generateDummyCrowdaction(
        joinStatus: JoinStatus.closed,
      );

      final tOpenCrowdAction = generateDummyCrowdaction(
        joinStatus: JoinStatus.open,
      );

      expect(tClosedCrowdAction.isOpen, false);
      expect(tOpenCrowdAction.isOpen, true);
    });

    test('Testing CommitmentOptions.mapIcon() method', () {
      crowdActionCommitmentIcons.forEach((key, value) {
        expect(tCommitmentOption.copyWith(iconId: key).icon, value);
      });
    });
  });

  group('Test of CrowdactionDto and its members', () {
    test('CrowdactionDto.toDomain() method', () {});

    test('CrowdactionDto.fromJson() method', () {});
  });
}
