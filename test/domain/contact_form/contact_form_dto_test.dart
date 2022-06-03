import 'package:collaction_app/domain/contact_form/contact_form_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import 'contact_form_fixture.dart';

void main() {
  group('Contact Form DTO Tests:', () {
    test('Test .fromJson() member', () {
      final tContactFormDto = ContactFormDto.fromJson(cContactFormJson);
      expect(tContactFormDto, isA<ContactFormDto>());
      expect(tContactFormDto, cContactFormDto);
    });

    test('Test subject default value', () {
      final tContactFormDto =
          ContactFormDto(email: 'another@test.com', message: 'Hello World!');
      expect(tContactFormDto.subject, cContactFormDtoDefault.subject);
    });
  });
}
