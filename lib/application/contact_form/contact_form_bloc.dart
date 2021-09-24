import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_form_event.dart';
part 'contact_form_state.dart';
part 'contact_form_bloc.freezed.dart';

class ContactFormContents {
  final String? email;
  final String? message;
  ContactFormContents({this.email, this.message});
}

class ContactFormBloc extends Bloc<ContactFormEvent, ContactFormState> {
  ContactFormBloc() : super(const _Initial());

  @override
  Stream<ContactFormState> mapEventToState(ContactFormEvent event) async* {
    yield event.when(
        submitted: (contents) {
          // TODO submit data to server
          Future.delayed(const Duration(seconds: 2)).then((value) => add(const ContactFormEvent.success()));
          return const ContactFormState.submitting();
        },
        error: (e) => ContactFormState.failed(e),
        success: () => const ContactFormState.submissionSuccessful());
  }
}
