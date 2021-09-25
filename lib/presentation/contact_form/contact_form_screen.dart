import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/contact_form/contact_form_bloc.dart';
import '../../application/crowdaction_getter/crowdaction_getter_bloc.dart';
import '../../domain/contact_form/contact_form_contents.dart';
import '../../infrastructure/core/injection.dart';
import '../shared_widgets/custom_app_bars/scrollable_app_bar.dart';
import '../shared_widgets/rectangle_button.dart';

// Create a Form widget.
class ContactFormPage extends StatefulWidget {
  const ContactFormPage({Key? key}) : super(key: key);

  @override
  ContactFormPageState createState() {
    return ContactFormPageState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class ContactFormPageState extends State<ContactFormPage> {
  late ScrollController _pageScrollController;
  final _contactFormBloc = getIt<ContactFormBloc>();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormFieldState>();
  ContactFormContents _formContents = ContactFormContents();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!EmailValidator.validate(value)) {
      return 'Please enter a valid email address';
    }
    _formContents =
        ContactFormContents(email: value, message: _formContents.message);
    return null;
  }

  String? _validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your feedback';
    }
    _formContents =
        ContactFormContents(email: _formContents.email, message: value);
    return null;
  }

  @override
  void initState() {
    super.initState();
    _pageScrollController = ScrollController();
  }

  void _contactFormBlocListener(BuildContext context, ContactFormState state) {
    // Remove any old snackbar
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    state.map(
        initial: (_) {},
        submitting: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Submitting form...'),
              duration: Duration(days: 1 /* display until removed */),
            ),
          );
        },
        submissionSuccessful: (_) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Success!')))
              .closed
              .then((value) => Navigator.pop(context));
        },
        failed: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error! Failed to submit form.')));
        });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: ScrollableAppBar(
          title: 'Contact form',
          pageScrollController: _pageScrollController,
        ),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior(), // TODO: use NoRippleBehavior(),
          child: SingleChildScrollView(
            controller: _pageScrollController,
            child: BlocConsumer<ContactFormBloc, ContactFormState>(
                listener: _contactFormBlocListener,
                bloc: _contactFormBloc,
                builder: (context, state) {
                  final isEnabled = state.maybeMap(
                      initial: (_) => true,
                      failed: (_) => true,
                      orElse: () => false);
                  return Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 100.0, horizontal: 23.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "We want to know what you think!",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 32.0),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 35.0),
                          TextFormField(
                            key: _emailKey,
                            onChanged: (value) =>
                                _emailKey.currentState!.validate(),
                            enabled: isEnabled,
                            validator: (value) => _validateEmail(value),
                            style: const TextStyle(fontSize: 20.0),
                            decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.alternate_email),
                                labelText: 'Email',
                                hintText: 'johndoe@example.org'),
                          ),
                          const SizedBox(height: 25.0),
                          TextFormField(
                            enabled: isEnabled,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            minLines: 5,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.feedback_outlined),
                              labelText: 'Give us your feedback or request',
                              hintText:
                                  'Give your feedback or request for starting a \ncrowdaction',
                            ),
                            validator: _validateMessage,
                          ),
                          const SizedBox(height: 35.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: RectangleButton(
                                  text: 'Let us know',
                                  enabled: isEnabled,
                                  onTap: isEnabled ? _submitForm : null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _contactFormBloc.add(ContactFormEvent.submitted(_formContents));
    }
  }
}
