import 'package:flutter/material.dart';

///import '../../../core/collaction_icons.dart';

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
      /// TODO: replace icons with variants from CollactionIcons
      icon: likedByMe
          ? const Icon(Icons.favorite)
          : const Icon(Icons.favorite_border),
      onPressed: onTap,
      iconSize: 14,
      splashRadius: 14,
      color: likedByMe ? Colors.redAccent : null,
    );
  }
}
