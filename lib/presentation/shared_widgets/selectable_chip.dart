import 'package:flutter/material.dart';

import '../themes/constants.dart';

class SelectableChip extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback? onTap;

  const SelectableChip({
    super.key,
    required this.text,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(
        milliseconds: 200,
      ),
      child: SizedBox(
        key: ValueKey<bool>(selected),
        child: TextButton(
          onPressed: onTap,
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets?>(
              const EdgeInsets.symmetric(horizontal: 10.0),
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              StadiumBorder(
                  side: BorderSide(
                      color: selected ? kPrimaryColor400 : kAlmostTransparent)),
            ),
            overlayColor: MaterialStateColor.resolveWith(
              (states) => kSecondaryColor.withOpacity(0.1),
            ),
            backgroundColor: MaterialStateProperty.all(
                selected ? kPrimaryColor400 : kSecondaryColor),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 11,
                  color: selected ? kSecondaryColor : kPrimaryColor400,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ),
    );
  }
}
