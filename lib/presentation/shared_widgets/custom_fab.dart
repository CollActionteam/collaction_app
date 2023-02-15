import 'package:flutter/material.dart';

import '../../core/core.dart';

class CustomFAB extends StatelessWidget {
  final Widget child;
  final bool isMini;
  final String? heroTag;
  final GestureTapCallback? onPressed;
  final Color? color;

  const CustomFAB({
    super.key,
    required this.child,
    this.isMini = false,
    this.heroTag = "fabBtn",
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      heroTag: heroTag,
      backgroundColor: color ??
          (onPressed != null
              ? context.kTheme.accentColor
              : context.kTheme.disabledButtonColor),
      mini: isMini,
      child: child,
    );
  }
}
