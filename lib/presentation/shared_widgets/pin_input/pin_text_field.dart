import 'package:flutter/material.dart';

import '../../themes/constants.dart';

class PinTextField extends StatelessWidget {
  final bool readOnly;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback? onPaste;

  const PinTextField({
    super.key,
    this.readOnly = false,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.onPaste,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.0125,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.width * 0.12,
        width: MediaQuery.of(context).size.width * 0.12,
        child: GestureDetector(
          onLongPress: onPaste,
          onTap: () => focusNode.requestFocus(),
          child: AbsorbPointer(
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
              focusNode: focusNode,
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }
}
