import 'package:flutter/material.dart';

import '../../themes/constants.dart';

class EnterVerificationCode extends StatefulWidget {
  final Function() reset;
  const EnterVerificationCode({Key? key, required this.reset}) : super(key: key);

  @override
  _EnterVerificationCodeState createState() => _EnterVerificationCodeState();
}

class _EnterVerificationCodeState extends State<EnterVerificationCode> {
  late FocusNode focusNode0,
      focusNode1,
      focusNode2,
      focusNode3,
      focusNode4,
      focusNode5;
  late TextEditingController digit0, digit1, digit2, digit3, digit4, digit5;

  @override
  void initState() {
    super.initState();

    focusNode0 = FocusNode();
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: const [
            Expanded(
              child: Text(
                'Enter your \r\nverification code',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 32.0),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _digitField(
                digit0,
                focusNode0,
                    (value) =>
                    _changeFocus(value, focusNode1, null)),
            _digitField(
                digit1,
                focusNode1,
                    (value) => _changeFocus(
                    value, focusNode2, focusNode0)),
            _digitField(
                digit2,
                focusNode2,
                    (value) => _changeFocus(
                    value, focusNode3, focusNode1)),
            _digitField(
                digit3,
                focusNode3,
                    (value) => _changeFocus(
                    value, focusNode4, focusNode2)),
            _digitField(
                digit4,
                focusNode4,
                    (value) => _changeFocus(
                    value, focusNode5, focusNode3)),
            _digitField(
                digit5,
                focusNode5,
                    (value) =>
                    _changeFocus(value, null, focusNode4)),
          ],
        ),
        const SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            ),
          ],
        ),
      ],
    );
  }

  Padding _digitField(TextEditingController controller, FocusNode focus,
      ValueChanged<String> onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.0125),
      child: SizedBox(
        height: MediaQuery.of(context).size.width * 0.12,
        width: MediaQuery.of(context).size.width * 0.12,
        child: TextFormField(
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
    if (value.isNotEmpty && next != null) {
      next.requestFocus();
      return;
    }

    if (value.isEmpty && previous != null) {
      previous.requestFocus();
      return;
    }

    if (value.isNotEmpty && next == null) {
      // TODO: Call validation method/BLOC
      return;
    }
  }

  @override
  void dispose() {
    // Page Two
    focusNode0.dispose();
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
    digit5.dispose();
    super.dispose();
  }
}
