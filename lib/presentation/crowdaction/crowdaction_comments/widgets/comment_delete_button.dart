import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CommentDeleteButton extends StatelessWidget {
  final Function()? onTap;

  const CommentDeleteButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Ionicons.trash_outline),
      onPressed: onTap,
      iconSize: 14,
      splashRadius: 14,
    );
  }
}
