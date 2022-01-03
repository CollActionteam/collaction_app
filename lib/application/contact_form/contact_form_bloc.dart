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

  ContactFormBloc(this._contactFormApi) : super(const _Initial()) {
    on<ContactFormEvent>((event, emit) async {
      emit(
        await event.map(
          submitted: (event) {
            _contactFormApi
                .sendContactFormContents(event.contents)
                .then(
                  (value) => add(
                    value
                        ? const ContactFormEvent.success()
                        : const ContactFormEvent.error(
                            'Submission not successful!',
                          ),
                  ),
                )
                .onError(
                  (error, stackTrace) => add(
                    const ContactFormEvent.error('Error submitting form!'),
                  ),
                );
            return const ContactFormState.submitting();
          },
          error: (event) {
            return ContactFormState.failed(event.message);
          },
          success: (_) {
            return const ContactFormState.submissionSuccessful();
          },
        ),
      );
    });
  }
}
