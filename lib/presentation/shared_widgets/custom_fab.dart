import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:flutter/material.dart';

class CustomFAB extends StatelessWidget {
  final Widget child;
  final bool isMini;
  final String? heroTag;
  final GestureTapCallback? onPressed;
  const CustomFAB({
    Key? key,
    required this.child,
    this.isMini = false,
    this.heroTag = "fabBtn",
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      heroTag: heroTag,
      backgroundColor: onPressed != null ? kAccentColor : kDisabledButtonColor,
      mini: isMini,
      child: child,
    );
  }
}
