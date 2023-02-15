import 'package:flutter/material.dart';

import '../../core/core.dart';

class SecondaryChip extends StatelessWidget {
  final String text;
  final Widget? leading;
  final VoidCallback? onDeleted;
  const SecondaryChip({
    super.key,
    required this.text,
    this.leading,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: leading,
      backgroundColor: context.kTheme.secondaryColor,
      shape: StadiumBorder(
        side: BorderSide(color: context.kTheme.almostTransparent!),
      ),
      label: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      deleteIcon: onDeleted != null ? const Icon(Icons.cancel) : null,
      onDeleted: onDeleted,
    );
  }
}
