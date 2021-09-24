part of 'contact_form_bloc.dart';

@freezed
class ContactFormEvent with _$ContactFormEvent {
  const factory ContactFormEvent.submitted(ContactFormContents contents) = _Submitted;
  const factory ContactFormEvent.error(String message) = _Error;
  const factory ContactFormEvent.success() = _Success;
}