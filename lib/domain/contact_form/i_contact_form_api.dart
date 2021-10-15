import 'contact_form_contents.dart';

abstract class IContactFormApi {
  Future<bool> sendContactFormContents(ContactFormContents contents);
}
