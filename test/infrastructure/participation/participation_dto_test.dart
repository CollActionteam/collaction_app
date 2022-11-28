import 'participation_dto_fixtures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:collaction_app/infrastructure/participation/participation_dto.dart';

void main() {
  group('Participation DTO tests', () {
    test('toDomain() test', () {
      final participation = tParticipationDto.toDomain();

      expect(participation, tParticipation);
    });
    test('fromJson() test', () {
      final participationDto = ParticipationDto.fromJson(tParticipationJson);

      expect(participationDto, tParticipationDto);
    });
  });
}
