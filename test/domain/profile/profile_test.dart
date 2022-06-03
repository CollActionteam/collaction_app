import 'package:collaction_app/infrastructure/profile/profile_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import 'profile_fixture.dart';

void main() {
  group('Tests of Profile DTO and its members:', () {
    test('ProfileDto.fromJson()', () {
      final profileDto = ProfileDto.fromJson(cProfileDtoJson);
      expect(profileDto, cProfileDtoFromJson);
    });

    test('ProfileDto.toDomain()', () {
      final profileDto = ProfileDto.fromJson(cProfileDtoJson);
      final profile = profileDto.toDomain();
      expect(profile, cProfileFromJson);
    });
  });
}
