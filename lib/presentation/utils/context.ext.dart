import 'package:flutter/material.dart';

import '../../core/core.dart';

extension ContextX on BuildContext {
  void showErrorSnack(String message) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: kTheme.errorColor,
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: TextStyle(color: kTheme.secondaryColor),
        ),
      ),
    );
  }
}
