import 'package:flutter/material.dart';

import '../themes/constants.dart';

class AccentChip extends StatelessWidget {
  final String text;
  final Widget? leading;
  final VoidCallback? onDeleted;
  final Color color;
  final bool noMaterialTapTargetSize;

  const AccentChip({
    super.key,
    required this.text,
    this.leading,
    this.onDeleted,
    this.color = kAccentColor,
    this.noMaterialTapTargetSize = false,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      materialTapTargetSize: noMaterialTapTargetSize
          ? MaterialTapTargetSize.shrinkWrap
          : MaterialTapTargetSize.padded,
      avatar: leading,
      backgroundColor: color,
      shape: StadiumBorder(side: BorderSide(color: color)),
      label: Text(
        text,
        style: Theme.of(context).textTheme.caption?.copyWith(
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
