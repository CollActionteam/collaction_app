import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/auth_bloc.dart';
import '../../shared_widgets/pill_button.dart';
import '../../themes/constants.dart';

class EnterUserName extends StatefulWidget {
  const EnterUserName({Key? key}) : super(key: key);

  @override
  _EnterUserNameState createState() => _EnterUserNameState();
}

class _EnterUserNameState extends State<EnterUserName> {
  final _firstUsernameController = TextEditingController();
  final _lastUsernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _firstNameKey = GlobalKey();
  final _lastNameKey = GlobalKey();
  bool _isNameValid = false;
  String? _username;
  String? _firstName;
  String? _lastName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: const [
                Expanded(
                  child: Text(
                    'How should we call\r\n you?',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 32.0),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: const [
                Expanded(
                  child: Text(
                    'Enter your first name or use a recognizable name that others can identify you by',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: kInactiveColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 45.0),
            Form(
              key: _formKey,
              onChanged: () => setState(
                () => _isNameValid = _formKey.currentState?.validate() == true,
              ),
              child: Column(
                children: [
                  TextFormField(
                    key: _firstNameKey,
                    controller: _firstUsernameController,
                    onChanged: (firstName) => _firstName = firstName,
                    style: const TextStyle(fontSize: 20.0),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Your First Name',
                      focusColor: kAccentColor,
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
                    validator: _validate,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp("[a-zA-Z0-9_.-]")),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    key: _lastNameKey,
                    controller: _lastUsernameController,
                    onChanged: (lastName) => _lastName = lastName,
                    style: const TextStyle(fontSize: 20.0),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Your Last Name',
                      focusColor: kAccentColor,
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
                    validator: _validate,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp("[a-zA-Z0-9_.-]")),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PillButton(
                    text: 'Next',
                    isLoading: state is AwaitingUsernameUpdate,
                    isEnabled: _isNameValid,
                    onTap: () {
                      if (_isNameValid && state is! AwaitingUsernameUpdate) {
                        FocusScope.of(context).unfocus();
                        _username = _firstName! + " " + _lastName!;
                        context
                            .read<AuthBloc>()
                            .add(AuthEvent.updateUsername(_username!));
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String? _validate(String? value) {
    if (Key == _firstNameKey) {
      if (value == null || value.trim().isEmpty) {
        return "First name is required";
      }

      if (value!.length < 2 || value.length > 20) {
        return "First name should be between 2 and 20 characters long";
      }

      if (!value.startsWith(RegExp("[a-zA-Z]"))) {
        return "First name should start with a letter";
      }
    } else {
      if (value == null || value.trim().isEmpty) {
        return "Last name is required";
      }

      if (value.length < 2 || value.length > 20) {
        return "Last name should be between 2 and 20 characters long";
      }

      if (!value.startsWith(RegExp("[a-zA-Z]"))) {
        return "Last name should start with a letter";
      }
    }

    return null;
  }

  @override
  void dispose() {
    _firstUsernameController.dispose();
    _lastUsernameController.dispose();
    super.dispose();
  }
}
