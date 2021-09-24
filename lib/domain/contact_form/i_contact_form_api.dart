import 'package:collaction_app/domain/contact_form/contact_form_contents.dart';

abstract class IContactFormApi {
  Future<bool> sendContactFormContents(ContactFormContents contents);
}
