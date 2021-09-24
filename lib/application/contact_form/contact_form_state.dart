part of 'contact_form_bloc.dart';

@freezed
class ContactFormState with _$ContactFormState {
  const factory ContactFormState.initial() = _Initial;
  const factory ContactFormState.submitting() = _Submitting;
  const factory ContactFormState.submissionSuccessful() = _SubmissionSuccessful;
  const factory ContactFormState.failed(String failureMessage) = _Failed;
}
