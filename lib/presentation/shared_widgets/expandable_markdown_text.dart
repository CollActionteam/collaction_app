import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../core/core.dart';
import '../themes/markdown_stylesheet.dart';
import '../utils/launch_url.dart';

class ExpandableMarkdown extends StatefulWidget {
  final String data;
  final ThemeData themeData;

  const ExpandableMarkdown({
    super.key,
    required this.data,
    required this.themeData,
  });

  @override
  State<ExpandableMarkdown> createState() => _ExpandableMarkdownState();
}

class _ExpandableMarkdownState extends State<ExpandableMarkdown>
    with SingleTickerProviderStateMixin {
  bool readMore = true;
  late String data;
  late List<String> lines;

  late AnimationController controller;
  late Animation<int> sizeAnimation;

  void onTapExpand() {
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
    lines = LineSplitter().convert(widget.data);

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    sizeAnimation = IntTween(
      begin: lines.length > 4 ? 4 : lines.length,
      end: lines.length,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));

    data = lines.take(sizeAnimation.value + 1).join('\n');

    controller.addListener(
      () => setState(() {
        data = lines.take(sizeAnimation.value + 1).join('\n');
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ExpandableMarkdownBody(
          data: data,
          themeData: widget.themeData,
          onTapLink: (_, href, __) => onTapLink(context, href),
        ),
        if (lines.length > 4) ...[
          GestureDetector(
            onTap: onTapExpand,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w300,
                        color: context.kTheme.accentColor,
                        fontSize: 17,
                        height: 1.5,
                      ),
                  children: [
                    if (readMore) ...[
                      TextSpan(text: '... '),
                    ],
                    TextSpan(
                      text: readMore ? 'Read more' : 'Read less',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> onTapLink(BuildContext context, String? href) async {
    if (href == null || href.isEmpty) {
      return;
    }

    await launchUrl(
      href,
      useWebView: true,
      context: context,
    );
  }
}

class _ExpandableMarkdownBody extends MarkdownWidget {
  final ThemeData themeData;

  _ExpandableMarkdownBody({
    required super.data,
    required this.themeData,
    super.onTapLink,
  }) : super(styleSheet: getStylesheetFromTheme(themeData));

  @override
  Widget build(BuildContext context, List<Widget>? children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children!,
    );
  }
}
