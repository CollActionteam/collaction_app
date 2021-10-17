import 'package:flutter/material.dart';

class PinTextField extends StatelessWidget {
  final bool readOnly;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const PinTextField(
      {Key? key,
      this.readOnly = false,
      required this.controller,
      required this.focusNode,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          focusNode: focusNode,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
