import 'package:collaction_app/infrastructure/participation/paginated_participations_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'paginated_participants_dto_fixtures.dart';

void main() {
  group('unit tests for the Paginated Participants DTO', () {
    test('toDomain() test', () {
      final paginatedParticipants = tPaginatedParticipantsDto.toDomain();

      expect(paginatedParticipants, tPaginatedParticipants);
    });
    test('fromJson() test', () {
      final paginatedParticipantsDto =
          PaginatedParticipationsDto.fromJson(tPaginatedParticipantsJson);

      expect(paginatedParticipantsDto, tPaginatedParticipantsDto);
    });
  });
}
