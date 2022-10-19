import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../themes/constants.dart';

/// Text widget to show read more and read less
class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.text, {
    super.key,
    this.trimLines = 3,
    this.clickableTextColor = kAccentColor,
    this.readMoreText = "more",
    this.readLessText = "less",
    this.style = const TextStyle(color: Colors.black),
  });

  /// Text to display
  final String text;

  /// How many lines to display
  final int trimLines;

  /// Read More & Read Less text color
  final Color clickableTextColor;

  /// Read More text
  final String readMoreText;

  /// Read Less text
  final String readLessText;

  /// Customize text style
  final TextStyle? style;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText>
    with SingleTickerProviderStateMixin {
  bool readMore = true;
  late String text;

  late AnimationController controller;
  late Animation<double> sizeAnimation;

  void onTapLink() {
    if (readMore) {
      controller.forward();
      readMore = false;
    } else {
      controller.reverse();
      readMore = true;
    }
  }

  @override
  void initState() {
    super.initState();
    text =
        '${widget.text.substring(0, widget.text.length > widget.trimLines * 30 ? widget.trimLines * 30 : widget.text.length)}... ';

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    sizeAnimation = Tween<double>(
      begin:
          showReadMore ? widget.trimLines * 30 : widget.text.length.toDouble(),
      end: widget.text.length.toDouble(),
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text:
                '${widget.text.substring(0, (sizeAnimation.value > widget.text.length ? widget.text.length : sizeAnimation.value).floor())}${showReadMore ? (readMore ? '... ' : ' ') : ''}',
            style: widget.style,
          ),
          if (showReadMore) ...[
            TextSpan(
              text: readMore ? widget.readMoreText : widget.readLessText,
              style: TextStyle(
                color: widget.clickableTextColor,
                decorationColor: widget.clickableTextColor,
                decorationStyle: TextDecorationStyle.solid,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTapLink,
            ),
          ]
        ],
      ),
    );
  }

  bool get showReadMore => widget.text.length > widget.trimLines * 30;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
