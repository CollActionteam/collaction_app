import 'package:flutter/material.dart';

import '../themes/constants.dart';

class PillButton extends StatelessWidget {
  final String text;
  final Widget? leading;
  final GestureTapCallback? onTap;
  final bool isEnabled;
  final EdgeInsets? margin;
  final double? width;
  const PillButton({
    Key? key,
    required this.text,
    this.leading,
    this.onTap,
    this.isEnabled = true,
    this.margin,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isEnabled ? kAccentColor : kDisabledButtonColor,
        borderRadius: BorderRadius.circular(52.0),
      ),
      margin: margin ??
          const EdgeInsets.symmetric(
            vertical: 6.0,
            horizontal: 12.0,
          ),
      child: InkWell(
        borderRadius: BorderRadius.circular(52.0),
        onTap: isEnabled ? onTap : null,
        child: Ink(
          height: 52,
          width: width ?? double.infinity,
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
