import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../shared_widgets/custom_appbar.dart';
import '../shared_widgets/rectangle_button.dart';

// Create a Form widget.
class ContactFormPage extends StatefulWidget {
  const ContactFormPage({Key? key}) : super(key: key);

  @override
  ContactFormState createState() {
    return ContactFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class ContactFormState extends State<ContactFormPage> {
  late ScrollController _pageScrollController;

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final Map<String, String?> _formData = {'email': null, 'message': null};
  bool _isEnabled = true;

  Future<void> submitForm(Map<String, String?> formData) {
    // TODO implement connection to microservice and replace placeholder below
    return Future.delayed(const Duration(seconds: 2), () {
      // print(formData);
    });
  }

  @override
  void initState() {
    super.initState();
    _pageScrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        context,
        title: 'Contact form',
        elevated: true,
        pageScrollController: _pageScrollController,
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior(), // TODO: use NoRippleBehavior(),
        child: SingleChildScrollView(
          controller: _pageScrollController,
          child: Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 100.0, horizontal: 23.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "We want to know what you think!",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 32.0),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 35.0),
                  TextFormField(
                    key: _emailKey,
                    onChanged: (value) => _emailKey.currentState!.validate(),
                    enabled: _isEnabled,
                    validator: (value) => _validateEmail(value),
                    style: const TextStyle(fontSize: 20.0),
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.alternate_email),
                        labelText: 'Email',
                        hintText: 'johndoe@gmail.com'),
                  ),
                  const SizedBox(height: 25.0),
                  TextFormField(
                    enabled: _isEnabled,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 5,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.feedback_outlined),
                      labelText: 'Give us your feedback or request',
                      hintText:
                          'Give your feedback or request for starting a \ncrowdaction',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your feedback';
                      }
                      _formData['message'] = value;
                      return null;
                    },
                  ),
                  const SizedBox(height: 35.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RectangleButton(
                          text: 'Let us know',
                          enabled: _isEnabled,
                          onTap: _isEnabled ? () => _validateForm() : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!EmailValidator.validate(value)) {
      return 'Please enter a valid email address';
    }
    _formData['email'] = value;
    return null;
  }

  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isEnabled = false;
      });

      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        // TODO: implement a BLOC and use a loading dialog
        const SnackBar(
          content: Text('Processing data'),
          duration: Duration(days: 1),
        ),
      );

      final future = submitForm(_formData);

      // Handle the success or failure of the form submission.
      future.then((value) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Success')))
            .closed
            .then((value) => Navigator.pop(context));
      }).catchError(
        (error) {
          setState(() {
            _isEnabled = true;
          });
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Error')));
        },
      );
    }
  }
}
