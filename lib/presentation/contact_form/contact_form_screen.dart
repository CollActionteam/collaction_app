import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/contact_form/contact_form_bloc.dart';
import '../../domain/contact_form/contact_form_dto.dart';
import '../../infrastructure/core/injection.dart';
import '../../presentation/shared_widgets/no_ripple_behavior.dart';
import '../../presentation/themes/constants.dart';
import '../shared_widgets/custom_app_bars/custom_appbar.dart';
import '../shared_widgets/pill_button.dart';

class ContactFormPage extends StatefulWidget {
  const ContactFormPage({Key? key}) : super(key: key);

  @override
  ContactFormPageState createState() {
    return ContactFormPageState();
  }
}

class ContactFormPageState extends State<ContactFormPage> {
  late ScrollController _pageScrollController;
  late ContactFormBloc _contactFormBloc;
  late GlobalKey<FormState> _formKey;
  late GlobalKey<FormFieldState> _emailKey;
  ContactFormDto? _formContents;

  @override
  void initState() {
    super.initState();
    _pageScrollController = ScrollController();
    _contactFormBloc = getIt<ContactFormBloc>();
    _formKey = GlobalKey<FormState>();
    _emailKey = GlobalKey<FormFieldState>();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(context),
        body: ScrollConfiguration(
          behavior: NoRippleBehavior(),
          child: SingleChildScrollView(
            controller: _pageScrollController,
            child: BlocConsumer<ContactFormBloc, ContactFormState>(
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 100.0, horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Contact us",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 32.0),
                            maxLines: 2,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 35.0),
                          TextFormField(
                            key: _emailKey,
                            onChanged: (value) =>
                                _emailKey.currentState!.validate(),
                            enabled: isEnabled,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(fontSize: 20.0),
                            decoration: InputDecoration(
                              hintText: 'Your email address',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                    width: 0, color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                    width: 0, color: Colors.transparent),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                    width: 0, color: Colors.transparent),
                              ),
                            ),
                            validator: (value) => _validateEmail(value),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 4, 0, 0),
                            child: Text(
                              "We will send our response to your email address",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: kPrimaryColor300),
                              maxLines: 2,
                              textAlign: TextAlign.left,
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
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                    width: 0, color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                    width: 0, color: Colors.transparent),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                    width: 0, color: Colors.transparent),
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
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  void _contactFormBlocListener(BuildContext context, ContactFormState state) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    state.map(
        initial: (_) {},
        submitting: (_) {},
        submissionSuccessful: (_) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(
                content: Text('Success!'),
                behavior: SnackBarBehavior.floating,
              ))
              .closed
              .then((value) => Navigator.pop(context));
        },
        failed: (_) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Error! Failed to submit form.'),
            behavior: SnackBarBehavior.floating,
          ));
        });
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
