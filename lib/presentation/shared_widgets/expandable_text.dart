import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../themes/constants.dart';

/// Text widget to show read more and read less
class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.text, {
    Key? key,
    this.trimLines = 3,
    this.clickableTextColor = kAccentColor,
    this.readMoreText = " more",
    this.readLessText = " less",
    this.style = const TextStyle(color: Colors.black),
  }) : super(key: key);

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

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final TextSpan link = TextSpan(
      text: _readMore ? widget.readMoreText : widget.readLessText,
      style: widget.style?.copyWith(color: widget.clickableTextColor),
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    final Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;
        // Create a TextSpan with data
        final text = TextSpan(
          text: widget.text,
          style: widget.style,
        );
        // Layout and measure link
        final TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection.rtl,
          maxLines: widget.trimLines,
          ellipsis: '...',
        );

        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        // Get the endIndex of data
        int endIndex;
        final pos = textPainter.getPositionForOffset(
          Offset(
            textSize.width - linkSize.width,
            textSize.height,
          ),
        );

        endIndex = textPainter.getOffsetBefore(pos.offset) ?? -1;

        TextSpan textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: _readMore ? widget.text.substring(0, endIndex) : widget.text,
            style: widget.style,
            children: _readMore
                ? <TextSpan>[const TextSpan(text: '...'), link]
                : [link],
          );
        } else {
          textSpan = TextSpan(
            text: widget.text,
            style: widget.style,
          );
        }

        return RichText(
          text: textSpan,
        );
      },
    );
    return result;
  }
}
