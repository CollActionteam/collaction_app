import 'package:collaction_app/infrastructure/crowdaction/crowdaction_comment_dto.dart';
import 'package:collaction_app/presentation/crowdaction/crowdaction_details/comments/crowdaction_comment.dart';
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
        children: [
          const CommentForm(),
          CrowdActionUserComment(
            comment: CrowdActionCommentDto.fromJson({
              "crowdactionID": "Stuff",
              "message":
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              "authorId": "2VHwkJn1GhZAvSCxYf2OKMIJBc72",
              "createdAt": DateTime.now().toString()
            }).toDomain(),
          ),
          const SizedBox(
            height: 200,
          )
        ],
      ),
    );
  }
}
