import 'package:collaction_app/infrastructure/crowdaction/crowdaction_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'images_dto_fixtures.dart';

void main() {
  group('Images tests', () {
    test('toDomain() test', () {
      final images = tImagesDto.toDomain();

      expect(images, tImages);
    });
    test('fromJson test', () {
      final imagesDto = ImagesDto.fromJson(tImagesJson);

      expect(imagesDto, tImagesDto);
    });
  });
}
