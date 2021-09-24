import 'package:flutter/material.dart';

import 'pin_text_field.dart';

class PinInput extends StatefulWidget {
  final int pinLength;
  final bool readOnly;
  final Function(String)? submit;

  const PinInput(
      {Key? key, this.pinLength = 6, this.readOnly = false, this.submit})
      : super(key: key);

  @override
  _PinInputState createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  late List<int> size;
  late List<FocusNode> focusNodes;
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    size = List<int>.generate(widget.pinLength, (i) => i);
    focusNodes = size.map((_) => FocusNode()).toList(growable: false);
    controllers = size
        .map(
          (_) => TextEditingController(),
        )
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: size.map(
        (index) {
          return PinTextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            onChanged: (value) {
              _onChanged(value, index);
            },
            readOnly: widget.readOnly,
          );
        },
      ).toList(growable: false),
    );
  }

  void _onChanged(String value, int index) {
    // If full submit
    if (_pin.length == widget.pinLength && widget.submit != null) {
      widget.submit!(_pin);
    }

    FocusNode? next, previous;

    // Not first
    if (index != 0) {
      previous = focusNodes[index - 1];
    }

    // Not last
    if (index != size.length - 1) {
      next = focusNodes[index + 1];
    }

    if (value.isNotEmpty && next != null) {
      next.requestFocus();
      return;
    }

    if (value.isEmpty && previous != null) {
      previous.requestFocus();
      return;
    }
  }

  String get _pin {
    return controllers.map((c) => c.text).join();
  }

  @override
  void dispose() {
    focusNodes.forEach((node) => node.dispose());
    controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }
}
