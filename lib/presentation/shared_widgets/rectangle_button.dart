import 'package:flutter/material.dart';

import '../themes/constants.dart';

class RectangleButton extends StatelessWidget {
  final String text;
  final Widget? leading;
  final GestureTapCallback? onTap;
  final bool enabled;
  final EdgeInsets? margin;
  final double? width;
  const RectangleButton({
    Key? key,
    required this.text,
    this.leading,
    this.onTap,
    this.enabled = true,
    this.margin,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ??
          const EdgeInsets.symmetric(
            vertical: 6.0,
            horizontal: 12.0,
          ),
      child: InkWell(
        onTap: enabled ? onTap : null,
        child: Ink(
          height: 52,
          width: width ?? double.infinity,
          color: enabled ? kAccentColor : kDisabledButtonColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: 6.0),
              ],
              Text(text, style: Theme.of(context).accentTextTheme.button),
            ],
          ),
        ),
      ),
    );
  }
}
