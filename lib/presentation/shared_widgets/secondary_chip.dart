import 'package:flutter/material.dart';

import '../themes/constants.dart';

class SecondaryChip extends StatelessWidget {
  final String text;
  final Widget? leading;
  final VoidCallback? onDeleted;
  const SecondaryChip({
    Key? key,
    required this.text,
    this.leading,
    this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: leading,
      backgroundColor: kSecondaryColor,
      shape: const StadiumBorder(side: BorderSide(color: kAlmostTransparent)),
      label: Text(
        text,
        style: Theme.of(context).textTheme.caption,
      ),
      deleteIcon: onDeleted != null ? const Icon(Icons.cancel) : null,
      onDeleted: onDeleted,
    );
  }
}
