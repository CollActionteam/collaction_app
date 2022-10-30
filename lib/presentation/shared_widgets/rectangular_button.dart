import 'package:flutter/material.dart';

import '../themes/constants.dart';

class RectangularButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final double height;
  final bool isEnabled;
  final bool isLoading;

  const RectangularButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isEnabled = false,
    this.isLoading = false,
    this.height = 50.0,
  });

  @override
  RectangularButtonState createState() => RectangularButtonState();
}

class RectangularButtonState extends State<RectangularButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.isEnabled ? widget.onPressed : null,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder?>(
          const RoundedRectangleBorder(),
        ),
        backgroundColor: widget.isEnabled
            ? MaterialStateProperty.all<Color?>(kEnabledButtonColor)
            : MaterialStateProperty.all<Color?>(kDisabledButtonColor),
        minimumSize: MaterialStateProperty.all<Size?>(
          Size(double.infinity, widget.height),
        ),
      ),
      child: widget.isLoading
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : Text(
              widget.text,
              style: const TextStyle(
                color: kSecondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
    );
  }
}
