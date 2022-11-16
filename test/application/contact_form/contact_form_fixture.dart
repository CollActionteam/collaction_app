import 'package:collaction_app/application/contact_form/contact_form_bloc.dart';
import 'package:collaction_app/infrastructure/contact_form/contact_form_dto.dart';

import '../../test_utilities.dart';

final tContactFormApi = MockContactFormApi();
final tContactFormBloc = ContactFormBloc(tContactFormApi);
final tContactFormDtoS =
    ContactFormDto(email: 'success@test.com', message: 'Success');
final tContactFormDtoF =
    ContactFormDto(email: 'failure@test.com', message: 'Failure');
final tContactFormDtoE =
    ContactFormDto(email: 'error@test.com', message: 'Error');
