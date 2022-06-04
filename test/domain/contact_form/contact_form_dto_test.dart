import 'package:collaction_app/domain/contact_form/contact_form_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'contact_form_fixture.dart';

void main() {
  group('Testing Contact form DTO', () {
    test('testing Contact form DTO', () async {
      expect(
        ContactFormDto(email: 'test@test.com', message: 'Testing DTO'),
        tContactForm,
      );
    });

    test('testing ContactFormDto.fromJson() method', () async {
      final jsonMap = {
        'email': 'test@test.com',
        'message': 'Testing fromJson()'
      };
      final result = ContactFormDto.fromJson(jsonMap);
      expect(result, isA<ContactFormDto>());
    });
  });
}
