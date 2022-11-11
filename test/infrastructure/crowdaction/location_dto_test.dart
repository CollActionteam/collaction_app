import 'dart:math';

import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:collaction_app/infrastructure/crowdaction/crowdaction_dto.dart';
import 'location_dto_fixtures.dart';

void main() {
  group('Location tests', () {
    test('toDomain() test', () {
      final Location = tLocationDto.toDomain();

      expect(Location, tLocation);
    });
    test('fromJson() test', () {
      final locationDto = LocationDto.fromJson(tLocationJson);

      expect(locationDto, tLocationDto);
    });
  });
}
