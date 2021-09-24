import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/verify_phone_bloc/verify_phone_bloc.dart';
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
    return BlocBuilder<VerifyPhoneBloc, VerifyPhoneState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              readOnly: state.isSendingSms,
              onChange: (response) {
                context
                    .read<VerifyPhoneBloc>()
                    .add(VerifyPhoneEvent.phoneChanged(response.contact));
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
                    isLoading: state.isSendingSms,
                    onPressed: () {
                      if (_isPhoneValid && !state.isSendingSms) {
                        // Hide keyboard
                        FocusScope.of(context).unfocus();

                        context
                            .read<VerifyPhoneBloc>()
                            .add(const VerifyPhoneEvent.verifyPhone());
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
}
