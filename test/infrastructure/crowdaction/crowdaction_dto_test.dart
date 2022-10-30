import 'package:collaction_app/infrastructure/crowdaction/crowdaction_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import 'crowdaction_dto_fixtures.dart';

void main() {
  group('CrowdActionDto tests', () {
    test('fromJson', () {
      final dto = CrowdActionDto.fromJson(crowdActionJson);
      expect(dto, crowdActionDto);
    });

    test('toDomain', () {
      final domain = crowdActionDto.toDomain();
      expect(domain, crowdActionDomain);
    });
  });
}
