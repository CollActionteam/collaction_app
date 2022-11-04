part of '../crowdaction_comments_page.dart';

class CommentItem extends StatelessWidget {
  final CrowdactionCommentDto comment;
  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 14, 14),
          decoration: BoxDecoration(
            color: kPrimaryColor0,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ExpandableText(
            comment.content,
            trimLines: 6,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                )
                .withLineHeight(20),
          ),
        ),
        const SizedBox(height: 12),
        CommentActions(comment: comment),
        const SizedBox(height: 16),
      ],
    );
  }
}
