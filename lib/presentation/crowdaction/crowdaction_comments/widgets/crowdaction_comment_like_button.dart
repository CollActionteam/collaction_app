import 'package:flutter/material.dart';

class CrowdActionCommentLikeButton extends StatelessWidget {
  final bool likedByMe;
  final Function()? onTap;

  const CrowdActionCommentLikeButton({
    super.key,
    required this.likedByMe,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: likedByMe
          ? const Icon(Icons.favorite)
          : const Icon(Icons.favorite_border),
      onPressed: onTap,
      iconSize: 14,
      splashRadius: 14,
      color: likedByMe ? const Color(0xFFDD3333) : const Color(0xFF666666),
      splashColor:
          likedByMe ? const Color(0x33666666) : const Color(0x33DD3333),
    );
  }
}
