import 'package:dartz/dartz.dart';

import '../../infrastructure/contact_form/contact_form_dto.dart';
import 'contact_failures.dart';

abstract class IContactRepository {
  Future<Either<ContactFailure, Unit>> sendContactFormContents(
    ContactFormDto contents,
  );
}
