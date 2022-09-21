import 'package:flutter/material.dart';

import '../themes/constants.dart';

class PillButton extends StatelessWidget {
  final String text;
  final Widget? leading;
  final GestureTapCallback? onTap;
  final bool isEnabled;
  final EdgeInsets? margin;
  final double? width;
  final bool isLoading;

  const PillButton({
    Key? key,
    required this.text,
    this.leading,
    this.onTap,
    this.isEnabled = true,
    this.margin,
    this.width,
    this.isLoading = false,
  }) : super(key: key);

  const PillButton.icon({
    Key? key,
    required this.text,
    required this.leading,
    this.onTap,
    this.isEnabled = true,
    this.margin,
    this.width,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ??
          const EdgeInsets.symmetric(
            vertical: 6.0,
            horizontal: 12.0,
          ),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: isLoading
            ? ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(52),
                  ),
                ),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : ElevatedButton.icon(
                icon: leading ?? const SizedBox(),
                label: Text(text),
                onPressed: isEnabled ? onTap : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) {
                      if (states.contains(MaterialState.disabled)) {
                        return kAlmostTransparent;
                      }
                      return kAccentColor;
                    },
                  ),
                  elevation: MaterialStateProperty.all<double>(0),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(52),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
