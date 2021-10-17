import 'package:flutter/material.dart';

import 'pin_text_field.dart';

class PinInput extends StatefulWidget {
  final int pinLength;
  final bool readOnly;
  final Function(String)? submit;

  const PinInput({
    Key? key,
    this.pinLength = 6,
    this.readOnly = false,
    this.submit,
  }) : super(key: key);

  @override
  PinInputState createState() => PinInputState();
}

class PinInputState extends State<PinInput> {
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

    FocusNode? next;
    FocusNode? previous;

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

  void autoComplete(String code) {
    if (code.length == widget.pinLength) {
      final digits = code.split("");
      digits.asMap().forEach((index, value) {
        controllers[index].text = value;
      });

      if (widget.submit != null) widget.submit!(_pin);
    }
  }

  String get _pin {
    return controllers.map((c) => c.text).join();
  }

  @override
  void dispose() {
    for (final node in focusNodes) {
      node.dispose();
    }

    for (final controller in controllers) {
      controller.dispose();
    }

    super.dispose();
  }
}
