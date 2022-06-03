import 'package:collaction_app/domain/contact_form/contact_form_dto.dart';

final cContactFormDto = ContactFormDto(
  email: 'test@test.com',
  subject: 'Hello',
  message: 'Testing DTO',
);

final cContactFormDtoDefault = ContactFormDto(
  email: 'test@test.com',
  message: 'Testing DTO',
);

const cContactFormJson = {
  'email': 'test@test.com',
  'subject': 'Hello',
  'message': 'Testing DTO'
};
