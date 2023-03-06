part of 'contact_form_bloc.dart';

abstract class ContactFormState extends Equatable {
  const ContactFormState();

  const factory ContactFormState.initial() = Initial;

  const factory ContactFormState.submitting() = Submitting;

  const factory ContactFormState.submissionSuccessful() = SubmissionSuccessful;

  const factory ContactFormState.failed(String failureMessage) = Failed;

  @override
  List<Object?> get props => [];
}

class Initial extends ContactFormState {
  const Initial();
}

class Submitting extends ContactFormState {
  const Submitting();
}

class SubmissionSuccessful extends ContactFormState {
  const SubmissionSuccessful();
}

class Failed extends ContactFormState {
  final String failureMessage;

  const Failed(this.failureMessage);

  @override
  List<Object?> get props => [failureMessage];
}
