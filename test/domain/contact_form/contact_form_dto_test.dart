import 'package:collaction_app/domain/contact_form/contact_form_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ContactFormDto tContactForm;
  setUp(() {
    tContactForm =
        ContactFormDto(email: 'test@test.com', message: 'Testing DTO');
  });
  test('testing Contact form DTO', () async {
    expect(
      ContactFormDto(email: 'test@test.com', message: 'Testing DTO'),
      tContactForm,
    );
  });

  test('testing ContactFormDto.fromJson() method', () async {
    final jsonMap = {'email': 'test@test.com', 'message': 'Testing fromJson()'};
    final result = ContactFormDto.fromJson(jsonMap);
    expect(result, isA<ContactFormDto>());
  });
}
