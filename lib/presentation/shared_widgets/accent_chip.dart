import 'package:flutter/material.dart';

import '../themes/constants.dart';

class AccentChip extends StatelessWidget {
  final String text;
  final Widget? leading;
  final VoidCallback? onDeleted;
  const AccentChip({
    Key? key,
    required this.text,
    this.leading,
    this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: leading,
      backgroundColor: kAccentColor,
      shape: const StadiumBorder(side: BorderSide(color: kAccentColor)),
      label: Text(
        text,
        style: Theme.of(context).accentTextTheme.caption,
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
