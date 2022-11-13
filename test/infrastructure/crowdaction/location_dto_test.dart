import 'package:collaction_app/infrastructure/crowdaction/crowdaction_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'location_dto_fixtures.dart';

void main() {
  group('Location tests', () {
    test('toDomain() test', () {
      final location = tLocationDto.toDomain();

      expect(location, tLocation);
    });
    test('fromJson() test', () {
      final locationDto = LocationDto.fromJson(tLocationJson);

      expect(locationDto, tLocationDto);
    });
  });
}
