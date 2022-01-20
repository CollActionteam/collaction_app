import 'package:flutter/material.dart';

import '../../../../domain/crowdaction/crowdaction.dart';
import 'crowdaction_comment_form.dart';

class CrowdActionComments extends StatelessWidget {
  final CrowdAction crowdAction;

  const CrowdActionComments({Key? key, required this.crowdAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [CommentForm()],
      ),
    );
  }
}
