import 'package:collaction_app/infrastructure/crowdaction/crowdaction_comment_dto.dart';
import 'package:collaction_app/presentation/crowdaction/crowdaction_details/comments/crowdaction_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/crowdaction/comments/crowdaction_comments_bloc.dart';
import '../../../../domain/crowdaction/crowdaction.dart';
import 'crowdaction_comment_form.dart';

class CrowdActionComments extends StatefulWidget {
  final CrowdAction crowdAction;

  const CrowdActionComments({Key? key, required this.crowdAction})
      : super(key: key);

  @override
  State<CrowdActionComments> createState() => _CrowdActionCommentsState();
}

class _CrowdActionCommentsState extends State<CrowdActionComments> {
  @override
  void initState() {
    context
        .read<CrowdactionCommentsBloc>()
        .add(CrowdactionCommentsEvent.loadComments(widget.crowdAction));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CommentForm(),
          BlocBuilder<CrowdactionCommentsBloc, CrowdactionCommentsState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: state.maybeMap(
                  loadedCrowdActionComments: (value) => value.comments
                      .map(
                        (comment) => CrowdActionUserComment(comment: comment),
                      )
                      .toList(),
                  orElse: () => [],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
