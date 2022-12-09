import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CommentLikeButton extends StatelessWidget {
  final bool likedByMe;
  final Function()? onTap;

  const CommentLikeButton({
    super.key,
    required this.likedByMe,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: likedByMe
          ? const Icon(Ionicons.heart)
          : const Icon(Ionicons.heart_outline),
      onPressed: onTap,
      iconSize: 14,
      splashRadius: 14,
      color: likedByMe ? Colors.redAccent : null,
    );
  }
}
