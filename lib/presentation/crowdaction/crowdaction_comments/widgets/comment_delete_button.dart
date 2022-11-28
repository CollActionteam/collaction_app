import 'package:flutter/material.dart';

import '../../../core/collaction_icons.dart';

class CommentDeleteButton extends StatelessWidget {
  final Function()? onTap;

  const CommentDeleteButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      /// TODO: replace icons with variants from CollactionIcons
      icon: const Icon(Icons.delete),
      onPressed: onTap,
      iconSize: 14,
      splashRadius: 14,
    );
  }
}
