import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/contact_form/i_contact_form_repository.dart';
import '../../infrastructure/contact_form/contact_form_dto.dart';

part 'contact_form_bloc.freezed.dart';
part 'contact_form_event.dart';
part 'contact_form_state.dart';

@injectable
class ContactFormBloc extends Bloc<ContactFormEvent, ContactFormState> {
  final IContactRepository _contactFormApi;

  ContactFormBloc(this._contactFormApi) : super(const _Initial()) {
    on<ContactFormEvent>(
      (event, emit) async {
        await event.when(
          submitted: (event) async {
            emit(const ContactFormState.submitting());

            final unitOrFailure =
                await _contactFormApi.sendContactFormContents(event);

            if (unitOrFailure.isRight()) {
              emit(const ContactFormState.submissionSuccessful());
            } else {
              emit(const ContactFormState.failed('Submission failed'));
            }
          },
        );
      },
    );
  }
}
