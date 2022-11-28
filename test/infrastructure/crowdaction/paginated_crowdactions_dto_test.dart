import 'package:collaction_app/infrastructure/crowdaction/paginated_crowdactions_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'paginated_crowdactions_dto_fixtures.dart';

void main() {
  group('unit tests for Paginated CrowdActions DTO', () {
    test('toDomain() test', () {
      final paginatedCrowdActions = tPaginatedCrowdActionsDto.toDomain();

      expect(paginatedCrowdActions, tPaginatedCrowdActions);
    });
    test('fromJson() test', () {
      final paginatedCrowdActionsDto =
          PaginatedCrowdActionsDto.fromJson(tPaginatedCrowdActionsJson);

      expect(paginatedCrowdActionsDto, tPaginatedCrowdActionsDto);
    });
  });
}
