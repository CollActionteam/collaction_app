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

  const PillButton.icon({
    Key? key,
    required this.text,
    required this.leading,
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
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: leading != null
            ? ElevatedButton.icon(
                icon: leading ?? Container(),
                label: Text(text),
                onPressed: isEnabled ? onTap : null,
                style: ElevatedButton.styleFrom(
                  primary: kAccentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(52),
                  ),
                ),
              )
            : ElevatedButton(
                onPressed: isEnabled ? onTap : null,
                style: ElevatedButton.styleFrom(
                  primary: kAccentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(52),
                  ),
                ),
                child: Text(text),
              ),
      ),
    );
  }
}
