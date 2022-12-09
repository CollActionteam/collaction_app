import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CommentFlagButton extends StatelessWidget {
  final bool flagged;

  final Function()? onTap;

  const CommentFlagButton({
    super.key,
    required this.flagged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: flagged
          ? const Icon(Ionicons.flag)
          : const Icon(Ionicons.flag_outline),
      onPressed: onTap,
      iconSize: 14,
      splashRadius: 14,
    );
  }
}
