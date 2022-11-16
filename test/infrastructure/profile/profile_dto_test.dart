import 'package:collaction_app/infrastructure/profile/profile_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import 'profile_fixtures.dart';

void main() {
  group('Profile tests', () {
    test('toDomain()', () {
      final profile = tProfileDto.toDomain();

      expect(profile, tProfile);
    });

    test('fromJson()', () {
      final profileDto = ProfileDto.fromJson(tProfileJson);

      expect(profileDto, tProfileDto);
    });
  });
}
