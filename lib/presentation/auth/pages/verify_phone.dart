import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/auth_bloc.dart';
import '../../shared_widgets/phone_input.dart';
import '../../shared_widgets/rectangular_button.dart';

class VerifyPhonePage extends StatefulWidget {
  const VerifyPhonePage({Key? key}) : super(key: key);

  @override
  VerifyPhonePageState createState() => VerifyPhonePageState();
}

class VerifyPhonePageState extends State<VerifyPhonePage> {
  var _isPhoneValid = false;

  // late PhoneInput _phoneInput;
  late TextEditingController _phoneInputController;
  var _phoneNumber = "";

  @override
  void initState() {
    super.initState();
    _phoneInputController = TextEditingController();
    // _phoneInput = PhoneInput(
    //   _phoneInputController,
    //   isValid: (valid) => setState(() => _isPhoneValid = valid),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Expanded(
                  child: Text(
                    'Verify your\r\nphone number',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 32.0),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            const SizedBox(height: 35.0),
            PhoneInput(
              _phoneInputController,
              readOnly: state is AwaitingVerification,
              onChange: (response) {
                _phoneNumber = response.contact;
              },
              isValid: (valid) => setState(() => _isPhoneValid = valid),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: RectangularButton(
                    text: 'Next',
                    isEnabled: _isPhoneValid,
                    isLoading: state is AwaitingVerification,
                    onPressed: () {
                      if (_isPhoneValid && state is! AwaitingVerification) {
                        // Hide keyboard
                        FocusScope.of(context).unfocus();

                        context
                            .read<AuthBloc>()
                            .add(AuthEvent.verifyPhone(_phoneNumber));
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

  void reset() {
    _phoneInputController.text = '';
    _isPhoneValid = false;
  }

  @override
  void dispose() {
    _phoneInputController.dispose();
    super.dispose();
  }
}
