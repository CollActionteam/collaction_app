import 'package:collaction_app/core/core.dart';
import 'package:collaction_app/infrastructure/crowdaction/crowdaction_comment_dto.dart';
import 'package:collaction_app/presentation/core/collaction_icons.dart';
import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:flutter/material.dart';

import '../../shared_widgets/expandable_text.dart';

part 'parts/comment_item.dart';
part 'parts/comment_textfield.dart';

class CrowdActionCommentsPage extends StatelessWidget {
  const CrowdActionCommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: kPrimaryColor400,
            expandedHeight: 156,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              titlePadding: const EdgeInsets.fromLTRB(10, 0, 10, 50),
              centerTitle: true,
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Comments',
                    style: kTitle1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'See what others are saying about this crowdaction and join in on the conversation',
                    style: kCaption1,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  )
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 20,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return CommentItem(comment: _comments[index]);
                },
                childCount: _comments.length,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Theme(
        data: context.themeFromPrimaryColor(kAccentColor),
        child: const CommentTextField(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

final _dummyComment = 'This is my comment for this crowdaction.';
final List<CrowdactionCommentDto> _comments = [
  CrowdactionCommentDto(
    crowdactionId: '',
    content: _dummyComment,
    userId: '',
    createdAt: DateTime.now(),
    likes: 2,
    likedByMe: false,
  ),
  CrowdactionCommentDto(
    crowdactionId: '',
    content: '$_dummyComment\n$_dummyComment',
    userId: '',
    createdAt: DateTime.now(),
    likes: 2,
    likedByMe: false,
  ),
  CrowdactionCommentDto(
    crowdactionId: '',
    content: _dummyComment + ('\n$_dummyComment') * 6,
    userId: '',
    createdAt: DateTime.now(),
    likes: 2,
    likedByMe: false,
  )
];
