import 'package:collaction_app/application/user_auth/verify_phone_bloc/verify_phone_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared_widgets/phone_input.dart';
import '../../shared_widgets/rectangular_button.dart';
import '../../utils/context.ext.dart';

class VerifyPhonePage extends StatefulWidget {
  final Function() onNext;

  const VerifyPhonePage({Key? key, required this.onNext}) : super(key: key);

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
    return BlocConsumer<VerifyPhoneBloc, VerifyPhoneState>(
      listener: (context, state) {
        if (state.isVerifySuccessful) {
          widget.onNext();
        } else if (state.authFailureOrSuccessOption.isSome()) {
          // Handle errors
          state.authFailureOrSuccessOption.fold(
              () {},
              (either) => context.showErrorSnack(
                    either.map(
                        serverError: (_) => "Server Error",
                        invalidPhone: (_) => "Invalid Phone",
                        verificationFailed: (_) => "Verification Failed"),
                  ));
        }
      },
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
                    isLoading: state.isVerifying,
                    onPressed: () {
                      if (_isPhoneValid) {
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
