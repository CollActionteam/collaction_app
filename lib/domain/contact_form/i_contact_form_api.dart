import 'package:collaction_app/domain/contact_form/contact_failures.dart';
import 'package:dartz/dartz.dart';

import 'contact_form_dto.dart';

abstract class IContactRepository {
  Future<Either<ContactFailure, Unit>> sendContactFormContents(
    ContactFormDto contents,
  );
}
