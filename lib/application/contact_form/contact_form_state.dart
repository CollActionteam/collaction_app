part of 'contact_form_bloc.dart';

abstract class ContactFormState extends Equatable {
  const ContactFormState();

  const factory ContactFormState.initial() = _Initial;

  const factory ContactFormState.submitting() = Submitting;

  const factory ContactFormState.submissionSuccessful() = _SubmissionSuccessful;

  const factory ContactFormState.failed(String failureMessage) = _Failed;

  @override
  List<Object?> get props => [];
}

class _Initial extends ContactFormState {
  const _Initial();
}

class Submitting extends ContactFormState {
  const Submitting();
}

class _SubmissionSuccessful extends ContactFormState {
  const _SubmissionSuccessful();
}

class _Failed extends ContactFormState {
  final String failureMessage;

  const _Failed(this.failureMessage);

  @override
  List<Object?> get props => [failureMessage];
}
