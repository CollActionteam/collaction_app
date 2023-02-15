import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/contact_form/contact_form_bloc.dart';
import '../../../core/core.dart';
import '../../../infrastructure/contact_form/contact_form_dto.dart';
import '../../../infrastructure/core/injection.dart';
import '../../../presentation/shared_widgets/pill_button.dart';

class ContactForm extends StatefulWidget {
  final bool centerTitle;

  const ContactForm({super.key, this.centerTitle = false});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  late ContactFormBloc _contactFormBloc;
  late GlobalKey<FormState> _formKey;
  late GlobalKey<FormFieldState> _emailKey;
  late bool centerTitle;
  ContactFormDto? _formContents;

  @override
  void initState() {
    super.initState();
    _contactFormBloc = getIt<ContactFormBloc>();
    _formKey = GlobalKey<FormState>();
    _emailKey = GlobalKey<FormFieldState>();
    centerTitle = widget.centerTitle;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactFormBloc, ContactFormState>(
      listener: _contactFormBlocListener,
      bloc: _contactFormBloc,
      builder: (context, state) {
        final isEnabled = state.maybeMap(
          initial: (_) => true,
          failed: (_) => true,
          orElse: () => false,
        );
        return Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: centerTitle
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              Text(
                "Get in touch",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 32.0,
                ),
                maxLines: 2,
                textAlign: centerTitle ? TextAlign.center : TextAlign.left,
              ),
              const SizedBox(height: 35.0),
              TextFormField(
                key: _emailKey,
                onChanged: (value) => _emailKey.currentState!.validate(),
                enabled: isEnabled,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(fontSize: 20.0),
                decoration: InputDecoration(
                  hintText: 'Your email address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
                validator: (value) => _validateEmail(value),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 0, 0),
                child: Row(
                  children: [
                    Text(
                      "We’ll get back to you by email",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: context.kTheme.primaryColor300),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
              TextFormField(
                enabled: isEnabled,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 5,
                decoration: InputDecoration(
                  hintText: 'Your message to us',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
                validator: _validateMessage,
                onChanged: _validateMessage,
              ),
              const SizedBox(height: 35.0),
              PillButton(
                text: 'Send',
                isLoading: state is Submitting,
                isEnabled: isEnabled,
                onTap: isEnabled ? _submitForm : null,
              ),
            ],
          ),
        );
      },
    );
  }

  void _contactFormBlocListener(BuildContext context, ContactFormState state) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    state.map(
      initial: (_) {},
      submitting: (_) {},
      submissionSuccessful: (_) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
              const SnackBar(
                content:
                    Text('Success! Thank you for contacting us \ud83d\ude42'),
                behavior: SnackBarBehavior.floating,
              ),
            )
            .closed
            .then((value) => Navigator.pop(context));
      },
      failed: (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error! Failed to submit form.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!EmailValidator.validate(value)) {
      return 'Please enter a valid email address';
    }
    _formContents =
        ContactFormDto(email: value, message: _formContents?.message ?? '');
    return null;
  }

  String? _validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your feedback';
    }
    _formContents =
        ContactFormDto(email: _formContents?.email ?? '', message: value);
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _contactFormBloc.add(ContactFormEvent.submitted(_formContents!));
    }
  }
}
