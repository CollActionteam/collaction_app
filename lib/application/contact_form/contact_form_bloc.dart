import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/contact_form/contact_form_dto.dart';
import '../../domain/contact_form/i_contact_form_api.dart';

part 'contact_form_bloc.freezed.dart';
part 'contact_form_event.dart';
part 'contact_form_state.dart';

@injectable
class ContactFormBloc extends Bloc<ContactFormEvent, ContactFormState> {
  final IContactFormApi _contactFormApi;

  ContactFormBloc(this._contactFormApi) : super(const _Initial());

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
