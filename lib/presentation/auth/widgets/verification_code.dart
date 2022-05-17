import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/auth_bloc.dart';
import '../../shared_widgets/pin_input/pin_input.dart';
import '../../themes/constants.dart';

class EnterVerificationCode extends StatefulWidget {
  final int pinLength;

  const EnterVerificationCode({Key? key, this.pinLength = 6}) : super(key: key);

  @override
  _EnterVerificationCodeState createState() => _EnterVerificationCodeState();
}

class _EnterVerificationCodeState extends State<EnterVerificationCode> {
  final _pinKey = GlobalKey<PinInputState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeMap(
          authError: (_) {},
          verificationCompleted: (verificationState) =>
              _pinKey.currentState?.autoComplete(verificationState.smsCode),
          codeRetrievalTimedOut: (credentials) =>
              // TODO: Remove this print
              // ignore: avoid_print
              print(credentials.credential?.smsCode ?? 'No SMS Code'),
          orElse: () {},
        );
      },
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
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: const [
                Expanded(
                  child: Text(
                    'We just sent you a text message with a 6-digit code to verify your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: kInactiveColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 45.0),
            PinInput(
              key: _pinKey,
              readOnly: state is SigningInUser,
              submit: (smsCode) {
                FocusScope.of(context).unfocus();
                context
                    .read<AuthBloc>()
                    .add(AuthEvent.signInWithPhone(smsCode));
              },
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state is SigningInUser || state is AwaitingCodeResend) ...[
                  const SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      color: kAccentColor,
                      strokeWidth: 2,
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: TextButton(
                      onPressed: () => context
                          .read<AuthBloc>()
                          .add(const AuthEvent.resendCode()),
                      child: const Text(
                        'No code? Click here and we will send a new one',
                        style: TextStyle(
                          color: kAccentColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        );
      },
    );
  }
}
