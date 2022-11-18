import 'dart:math';

import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/infrastructure/crowdaction/crowdaction_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'top_participant_fixtures.dart';

void main() {
  group('Top Participant tests', () {
    test('toDomain() test', () {
      final topParticipant = tTopParticipantDto.toDomain();

      expect(topParticipant, tTopParticipant);
    });
    test('fromJson() test', () {
      final topParticipantDto = TopParticipantDto.fromJson(tTopParticipantJson);

      expect(topParticipantDto, tTopParticipantDto);
    });
  });
}
