import 'package:flutter/material.dart';

import '../../core/core.dart';

class RectangleButton extends StatelessWidget {
  final String text;
  final GestureTapCallback? onTap;
  final bool enabled;
  final Widget? leading;
  const RectangleButton({
    super.key,
    required this.text,
    this.onTap,
    this.enabled = true,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: enabled ? onTap : null,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color?>(
          context.kTheme.secondaryColor?.withOpacity(0.1),
        ),
        padding: MaterialStateProperty.all<EdgeInsets?>(
          const EdgeInsets.symmetric(vertical: 16.0),
        ),
        backgroundColor: enabled
            ? MaterialStateProperty.all<Color?>(
                context.kTheme.enabledButtonColor)
            : MaterialStateProperty.all<Color?>(
                context.kTheme.disabledButtonColor),
        shape: MaterialStateProperty.all<OutlinedBorder?>(
          const RoundedRectangleBorder(),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 6.0),
          ],
          Text(
            text,
            style: TextStyle(
              color: context.kTheme.secondaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
