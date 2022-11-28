import 'package:flutter/material.dart';

import '../../../core/collaction_icons.dart';

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
      /// TODO: replace icons with variants from CollactionIcons
      icon: flagged ? const Icon(Icons.flag) : const Icon(Icons.flag_outlined),
      onPressed: onTap,
      iconSize: 14,
      splashRadius: 14,
    );
  }
}
