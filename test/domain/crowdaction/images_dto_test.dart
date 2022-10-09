//* Fixtures for ImagesDto tests

import 'package:collaction_app/infrastructure/crowdaction/crowdaction_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import 'images_test_fixtures.dart';

void main() {
  group('Test of Images DTO', () {
    test('ImagesDTO.fromJson()', () {
      final imagesDto = ImagesDto.fromJson(imagesDtoJson);
      expect(imagesDto, imagesDtoFromJson);
    });
    test('ImagesDTO.toDomain()', () {
      final imagesDto = ImagesDto.fromJson(imagesDtoJson);
      final images = imagesDto.toDomain();
      expect(images, imagesFromJson);
    });
  });
}
