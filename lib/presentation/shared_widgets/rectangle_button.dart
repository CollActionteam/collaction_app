import 'package:flutter/material.dart';

import '../themes/constants.dart';

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
          kSecondaryColor.withOpacity(0.1),
        ),
        padding: MaterialStateProperty.all<EdgeInsets?>(
          const EdgeInsets.symmetric(vertical: 16.0),
        ),
        backgroundColor: enabled
            ? MaterialStateProperty.all<Color?>(kEnabledButtonColor)
            : MaterialStateProperty.all<Color?>(kDisabledButtonColor),
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
            style: const TextStyle(
              color: kSecondaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
