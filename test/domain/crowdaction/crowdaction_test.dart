import 'package:flutter_test/flutter_test.dart';

import 'crowdaction_fixture.dart';

void main() {
  group('Tests for Crowdaction:', () {
    test('Test getter hasParticipants', () {
      expect(cCrowdActionPassword.hasParticipants, true);
      expect(cCrowdActionNoPassword.hasParticipants, false);
    });

    test('Test getter hasPassword', () {
      expect(cCrowdActionPassword.hasPassword, true);
      expect(cCrowdActionNoPassword.hasPassword, false);
    });

    test('Test getter isOpen', () {
      expect(cCrowdActionPassword.isOpen, true);
      expect(cCrowdActionNoPassword.isOpen, false);
    });

    test('Test toChips()', () {
      expect(cCrowdActionPassword.toChips(), cCrowdActionPasswordToChips);
      expect(cCrowdActionNoPassword.toChips(), cCrowdActionNoPasswordToChips);
    });
  });

  group('Tests for CommitmentOption:', () {
    test('Test getter icon', () {
      expect(cCommitmentOption.icon, cCommitmentOptionIcon);
    });
  });
}
