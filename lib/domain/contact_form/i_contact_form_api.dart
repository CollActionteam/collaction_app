import 'contact_form_dto.dart';

abstract class IContactFormApi {
  Future<bool> sendContactFormContents(ContactFormDto contents);
}
