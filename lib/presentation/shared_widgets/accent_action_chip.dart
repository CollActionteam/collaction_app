import 'package:flutter/material.dart';

import '../themes/constants.dart';

class AccentActionChip extends StatelessWidget {
  final String text;
  final Widget? leading;
  final VoidCallback? onDeleted;
  final GestureTapCallback? onTap;
  final bool enabled;
  const AccentActionChip(this.onTap,
      {Key? key,
      required this.text,
      this.leading,
      this.onDeleted,
      this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: enabled ? onTap : null,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets?>(
            const EdgeInsets.symmetric(horizontal: 10.0)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
            const StadiumBorder(side: BorderSide(color: kAccentColor))),
        overlayColor: MaterialStateColor.resolveWith(
            (states) => kSecondaryColor.withOpacity(0.1)),
        backgroundColor:
            MaterialStateProperty.resolveWith((states) => kAccentColor),
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 5),
          ],
          Text(
            text,
            style: Theme.of(context).accentTextTheme.caption,
          )
        ],
      ),
    );
  }
}
