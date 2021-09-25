import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/verify_phone_bloc/verify_phone_bloc.dart';
import '../../shared_widgets/pin_input/pin_input.dart';
import '../../themes/constants.dart';

class EnterVerificationCode extends StatefulWidget {
  final Function() reset;
  final int pinLength;

  const EnterVerificationCode(
      {Key? key, required this.reset, this.pinLength = 6})
      : super(key: key);

  @override
  _EnterVerificationCodeState createState() => _EnterVerificationCodeState();
}

class _EnterVerificationCodeState extends State<EnterVerificationCode> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyPhoneBloc, VerifyPhoneState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: const [
                Expanded(
                  child: Text(
                    'Enter your \r\nverification code',
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
                    'We just sent you a text message with a 4-digit code to verify your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: kInactiveColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 45.0),
            PinInput(
              readOnly: state is SigningInUser,
              submit: (smsCode) {
                FocusScope.of(context).unfocus();
                context
                    .read<VerifyPhoneBloc>()
                    .add(VerifyPhoneEvent.signInWithPhone(smsCode));
              },
            ),
            const SizedBox(height: 15.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (state is SigningInUser)
                const SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    color: kAccentColor,
                    strokeWidth: 2,
                  ),
                )
              else
                Expanded(
                  child: TextButton(
                    onPressed: widget.reset,
                    child: const Text(
                        'No code? Click here and we will send a new one',
                        style: TextStyle(
                            color: kAccentColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0)),
                  ),
                )
            ]),
          ],
        );
      },
    );
  }
}
