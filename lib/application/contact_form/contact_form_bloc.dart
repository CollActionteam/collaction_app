import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/contact_form/contact_form_contents.dart';
import '../../domain/contact_form/i_contact_form_api.dart';
import '../../infrastructure/core/injection.dart';

part 'contact_form_bloc.freezed.dart';
part 'contact_form_event.dart';
part 'contact_form_state.dart';

class ContactFormBloc extends Bloc<ContactFormEvent, ContactFormState> {
  late final IContactFormApi _contactFormApi;

  ContactFormBloc() : super(const _Initial()) {
    _contactFormApi = getIt<IContactFormApi>();
  }

  @override
  Stream<ContactFormState> mapEventToState(ContactFormEvent event) async* {
    yield event.when(
        submitted: (contents) {
          _contactFormApi
              .sendContactFormContents(contents)
              .then((value) => add(value
                  ? const ContactFormEvent.success()
                  : const ContactFormEvent.error('Submission not successful!')))
              .onError((error, stackTrace) =>
                  add(const ContactFormEvent.error('Error submitting form!')));
          return const ContactFormState.submitting();
        },
        error: (e) => ContactFormState.failed(e),
        success: () => const ContactFormState.submissionSuccessful());
  }
}
