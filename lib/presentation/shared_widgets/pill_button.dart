import 'package:flutter/material.dart';

import '../../core/core.dart';

class PillButton extends StatelessWidget {
  final String text;
  final Widget? leading;
  final GestureTapCallback? onTap;
  final bool isEnabled;
  final EdgeInsets? margin;
  final double? width;
  final bool isLoading;
  final bool lightBackground;

  const PillButton({
    super.key,
    required this.text,
    this.leading,
    this.onTap,
    this.isEnabled = true,
    this.margin,
    this.width,
    this.isLoading = false,
    this.lightBackground = false,
  });

  const PillButton.icon({
    super.key,
    required this.text,
    required this.leading,
    this.onTap,
    this.isEnabled = true,
    this.margin,
    this.width,
    this.isLoading = false,
    this.lightBackground = false,
  });

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
                  backgroundColor: lightBackground
                      ? Colors.white
                      : context.colors.accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(52),
                  ),
                ),
                child: CircularProgressIndicator(
                  color: lightBackground
                      ? context.colors.accentColor
                      : Colors.white,
                ),
              )
            : ElevatedButton.icon(
                icon: leading ?? const SizedBox(),
                label: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: lightBackground
                        ? context.colors.accentColor
                        : Colors.white,
                  ),
                ),
                onPressed: isEnabled ? onTap : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) {
                      if (states.contains(MaterialState.disabled)) {
                        return context.kTheme.almostTransparent;
                      }
                      return lightBackground
                          ? Colors.white
                          : context.colors.accentColor;
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
