part of 'contact_form_bloc.dart';

@freezed
class ContactFormEvent with _$ContactFormEvent {
  const factory ContactFormEvent.submitted(ContactFormDto contents) =
      _Submitted;
}
