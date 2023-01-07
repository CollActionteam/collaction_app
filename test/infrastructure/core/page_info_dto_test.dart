import 'package:flutter_test/flutter_test.dart';
import 'page_info_dto_fixtures.dart';
import 'package:collaction_app/infrastructure/core/page_info_dto.dart';

void main() {
  group('tests for page info dto', () {
    test('page info toDomain() test', () {
      final pageInfo = tPageInfoDto.toDomain();

      expect(pageInfo, tPageInfo);
    });
    test('page info dto fromJson test', () {
      final pageInfoDto = PageInfoDto.fromJson(tPageInfoJson);

      expect(pageInfoDto, tPageInfoDto);
    });
  });
}
