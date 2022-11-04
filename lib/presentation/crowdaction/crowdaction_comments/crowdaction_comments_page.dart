import 'package:collaction_app/core/core.dart';
import 'package:collaction_app/infrastructure/crowdaction/crowdaction_comment_dto.dart';
import 'package:collaction_app/presentation/core/collaction_icons.dart';
import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:flutter/material.dart';

import '../../shared_widgets/expandable_text.dart';

part 'parts/comment_actions.dart';
part 'parts/comment_item.dart';
part 'parts/comment_textfield.dart';
part 'parts/comment_page_header.dart';

class CrowdActionCommentsPage extends StatelessWidget {
  const CrowdActionCommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CommentPageHeader(),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              30,
              0,
              30,
              MediaQuery.of(context).padding.bottom,
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

const _dummyComment = 'This is my comment for this crowdaction.';
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
    likedByMe: true,
  ),
  CrowdactionCommentDto(
    crowdactionId: '',
    content: _dummyComment + ('\n$_dummyComment') * 6,
    userId: '',
    createdAt: DateTime.now(),
    likes: 2,
    likedByMe: false,
    flagged: true,
  ),
  CrowdactionCommentDto(
    crowdactionId: '',
    content: _dummyComment + ('\n$_dummyComment') * 3,
    userId: '',
    createdAt: DateTime.now(),
    likes: 2,
    likedByMe: false,
    flagged: true,
  )
];
