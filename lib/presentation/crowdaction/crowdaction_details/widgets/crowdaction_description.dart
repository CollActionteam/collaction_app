import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shared_widgets/expandable_markdown_text.dart';
import '../../../themes/constants.dart';

class CrowdActionDescription extends StatefulWidget {
  final String? description;

  const CrowdActionDescription({
    super.key,
    required this.description,
  });

  @override
  State<CrowdActionDescription> createState() => _CrowdActionDescriptionState();
}

class _CrowdActionDescriptionState extends State<CrowdActionDescription> {
  @override
  Widget build(BuildContext context) {
    if (widget.description == null) {
      return Shimmer.fromColors(
        baseColor: kPrimaryColor100,
        highlightColor: kPrimaryColor200,
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: kPrimaryColor100,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }

    return ExpandableMarkdown(
      data: widget.description!,
      themeData: Theme.of(context),
    );
  }
}
