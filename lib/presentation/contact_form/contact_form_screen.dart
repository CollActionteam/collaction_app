import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

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
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final Map<String, String?> _formData = {'email': null, 'message': null};
  bool _isEnabled = true;

  Future<void> submitForm(Map<String, String?> formData) {
    // TODO implement connection to microservice and replace placeholder below
    return Future.delayed(const Duration(seconds: 2), () {
      // print(formData);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(title: const Text("Contact form")),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  enabled: _isEnabled,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.alternate_email),
                    hintText: 'example@mail.com',
                    labelText: 'Your email address',
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!EmailValidator.validate(value)) {
                      return 'Please enter a valid email address';
                    }
                    _formData['email'] = value;
                    return null;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                TextFormField(
                  enabled: _isEnabled,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.feedback_outlined),
                    hintText:
                        '''Give your feedback or request for starting a crowd action''',
                    labelText: 'Your feedback or request',
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your feedback';
                    }
                    _formData['message'] = value;
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // _formKey.currentState
                        setState(() {
                          _isEnabled = false;
                        });

                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
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
                              .showSnackBar(
                                  const SnackBar(content: Text('Success')))
                              .closed
                              .then((value) => Navigator.pop(context));
                        }).catchError((error) {
                          setState(() {
                            _isEnabled = true;
                          });
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Error')));
                        });
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
