import 'package:collaction_app/presentation/shared_widgets/pin_input/pin_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/verify_phone_bloc/verify_phone_bloc.dart';
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
  /* late FocusNode focusNode0,
      focusNode1,
      focusNode2,
      focusNode3,
      focusNode4,
      focusNode5;
  late TextEditingController digit0, digit1, digit2, digit3, digit4, digit5;
*/
  @override
  void initState() {
    super.initState();

    /*   focusNode0 = FocusNode();
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
    focusNode5 = FocusNode();
    digit0 = TextEditingController();
    digit1 = TextEditingController();
    digit2 = TextEditingController();
    digit3 = TextEditingController();
    digit4 = TextEditingController();
    digit5 = TextEditingController();
  */
  }

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
              readOnly: state.isSigningIn,
              submit: (smsCode) {
                FocusScope.of(context).unfocus();
                context
                    .read<VerifyPhoneBloc>()
                    .add(VerifyPhoneEvent.signInWithPhone(smsCode));
              },
            ),
            const SizedBox(height: 15.0),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: state.isSigningIn
                    ? [
                        const SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            color: kAccentColor,
                            strokeWidth: 2,
                          ),
                        ),
                      ]
                    : [
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

/*
  Padding _digitField(TextEditingController controller, FocusNode focus,
      ValueChanged<String> onChanged,
      {bool readOnly = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.0125),
      child: SizedBox(
        height: MediaQuery.of(context).size.width * 0.12,
        width: MediaQuery.of(context).size.width * 0.12,
        child: TextFormField(
          readOnly: readOnly,
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          showCursor: false,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 28),
          maxLength: 1,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            counterText: "",
          ),
          focusNode: focus,
          onChanged: onChanged,
        ),
      ),
    );
  }

  void _changeFocus(String value, FocusNode? next, FocusNode? previous) {
    // TODO - Check if all values are filled
    // If yes ... make read only and start validation
    // context.read<VerifyPhoneBloc>.add(
    //     const VerifyPhoneEvent.smsCodeChanged(_smsCode));
    // if (_smsCode.length == 6) {
    //   // Do auth
    //   context.read<VerifyPhoneBloc>.add(
    //       const VerifyPhoneEvent.signInWithPhone());
    // } else {
      if (value.isNotEmpty && next != null) {
        next.requestFocus();
        return;
      }

      if (value.isEmpty && previous != null) {
        previous.requestFocus();
        return;
      }

      // if (value.isNotEmpty && next == null) {
      //   // TODO: Call validation method/BLOC
      //
      //   return;
      // }
    // }
  }

  String get _smsCode {
    return "${digit0.text}${digit1.text}${digit2.text}${digit3.text}${digit4.text}${digit5.text}";
  }

  void _autoCompleteSms() {
    // try{
    //   final sms = widget.smsCode!.split("");
    //
    //   if(sms.length == 6) {
    //     digit0.text = sms[0];
    //     digit1.text = sms[1];
    //     digit2.text = sms[2];
    //     digit3.text = sms[3];
    //     digit4.text = sms[4];
    //     digit5.text = sms[5];
    //   }
    // }catch(_){
    //
    // }
  }
*/
  @override
  void dispose() {
    // Page Two
    /*   focusNode0.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    digit0.dispose();
    digit1.dispose();
    digit2.dispose();
    digit3.dispose();
    digit4.dispose();
    digit5.dispose();*/
    super.dispose();
  }
}
