import 'package:collaction_app/domain/contact_form/contact_form_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'contact_form_fixture.dart';

void main() {
  group('Testing Contact form DTO', () {
    
    test('Testing ContactFormDto.fromJson() method', () async {
      final jsonMap = {
        'email': 'test@test.com',
        'message': 'Testing fromJson()'
      };
      final result = ContactFormDto.fromJson(jsonMap);
      expect(result, isA<ContactFormDto>());
    });

    test('Test subject default value', () {
      final tContactFormDTO = ContactFormDto(
        email: 'another@test.com',
        message: 'Hello CollAction!',
      );
      expect(tContactFormDTO.subject, tContactForm.subject);
    });
  });
}
