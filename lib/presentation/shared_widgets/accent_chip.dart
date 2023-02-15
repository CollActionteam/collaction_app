import 'package:flutter/material.dart';

import '../../core/core.dart';

class AccentChip extends StatelessWidget {
  final String text;
  final Widget? leading;
  final VoidCallback? onDeleted;
  final Color? color;
  final bool noMaterialTapTargetSize;

  const AccentChip({
    super.key,
    required this.text,
    this.leading,
    this.onDeleted,
    this.color,
    this.noMaterialTapTargetSize = false,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      materialTapTargetSize: noMaterialTapTargetSize
          ? MaterialTapTargetSize.shrinkWrap
          : MaterialTapTargetSize.padded,
      avatar: leading,
      backgroundColor: color ?? context.kTheme.accentColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: color ?? context.kTheme.accentColor!,
        ),
      ),
      label: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white,
            ),
      ),
      deleteIcon: onDeleted != null
          ? const Icon(
              Icons.cancel,
              color: Colors.white,
            )
          : null,
      onDeleted: onDeleted,
    );
  }
}
