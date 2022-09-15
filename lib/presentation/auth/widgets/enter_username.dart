import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/username_bloc.dart';
import '../../shared_widgets/pill_button.dart';
import '../../themes/constants.dart';

class EnterUserName extends StatefulWidget {
  const EnterUserName({Key? key}) : super(key: key);

  @override
  _EnterUserNameState createState() => _EnterUserNameState();
}

class _EnterUserNameState extends State<EnterUserName> {
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _firstnameKey = GlobalKey();
  final _lastnameKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  bool _isNameValid = false;
  String? _firstname;
  String? _lastname;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsernameBloc, UsernameState>(
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
                    controller: _firstnameController,
                    key: _firstnameKey,
                    onChanged: (firstname) => _firstname = firstname,
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
                    validator: _validateFirstName,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                    ],
                  ),
                  const SizedBox(height: 25.0),
                  TextFormField(
                    controller: _lastnameController,
                    key: _lastnameKey,
                    onChanged: (lastname) => _lastname = lastname,
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
                    validator: _validateLastName,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
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
                        context.read<UsernameBloc>().add(
                            UsernameEvent.updateUsername(
                                _firstname!, _lastname!));
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

  String? _validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "First name is required";
    }

    if (value.length < 4 || value.length > 20) {
      return "First name should be between 4 and 60 characters long";
    }

    if (!value.startsWith(RegExp("[a-zA-Z]"))) {
      return "First name should start with a letter or number";
    }

    return null;
  }

  String? _validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Last name is required";
    }

    if (value.length < 4 || value.length > 20) {
      return "Last name should be between 4 and 60 characters long";
    }

    if (!value.startsWith(RegExp("[a-zA-Z]"))) {
      return "Last name should start with a letter or number";
    }

    return null;
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    super.dispose();
  }
}
