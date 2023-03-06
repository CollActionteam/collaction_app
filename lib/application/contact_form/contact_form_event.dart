part of 'contact_form_bloc.dart';

abstract class ContactFormEvent extends Equatable {
  final ContactFormDto contents;

  const ContactFormEvent(this.contents);

  const factory ContactFormEvent.submitted(ContactFormDto contents) =
      _Submitted;

  @override
  List<Object?> get props => [contents];
}

class _Submitted extends ContactFormEvent {
  const _Submitted(super.contents);
}
