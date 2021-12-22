import 'package:flutter/material.dart';

import '../themes/constants.dart';

extension ContextX on BuildContext {
  void showErrorSnack(String message) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      backgroundColor: kErrorColor,
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: const TextStyle(color: kSecondaryColor),
      ),
    ));
  }
}
