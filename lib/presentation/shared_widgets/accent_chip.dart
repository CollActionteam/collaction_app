import 'package:flutter/material.dart';

import '../themes/constants.dart';

class AccentChip extends StatelessWidget {
  final String text;
  final Widget? leading;
  final VoidCallback? onDeleted;
  final Color color;

  const AccentChip({
    Key? key,
    required this.text,
    this.leading,
    this.onDeleted,
    this.color = kAccentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
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
