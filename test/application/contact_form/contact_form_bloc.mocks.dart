import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/contact_form/contact_form_bloc.dart';

class MockContactFormBloc extends MockBloc<ContactFormEvent, ContactFormState>
    implements ContactFormBloc {}
