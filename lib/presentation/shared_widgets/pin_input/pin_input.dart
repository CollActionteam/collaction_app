import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/constants.dart';

class PinInput extends StatefulWidget {
  final int pinLength;
  final bool readOnly;
  final Function(String) submit;

  const PinInput({
    super.key,
    this.pinLength = 6,
    this.readOnly = false,
    required this.submit,
  });

  @override
  PinInputState createState() => PinInputState();
}

class PinInputState extends State<PinInput> {
  static const int backspace = 0x100000008;

  late FocusNode focusNode;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            textAlign: TextAlign.center,
            maxLength: 6,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            ],
            style: const TextStyle(fontSize: 28, letterSpacing: 4),
            cursorColor: kAccentColor,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              counterText: "",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide:
                    const BorderSide(width: 0, color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: kAccentColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: kAccentColor),
              ),
            ),
            onChanged: (value) {
              if (value.length == widget.pinLength) {
                widget.submit(value);
              }
            },
          ),
        ),
      ],
    );
  }

  void autoComplete(String code) {
    if (code.length == widget.pinLength) {
      widget.submit(code);
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }
}
