part of '../crowdaction_comments_page.dart';

/// The comment body that includes the commenter's avatar and name
/// along with the comment content.
///
/// This also has [CommentActions] at the bottom.
///
/// Currently, this takes a [CrowdactionCommentDto] variable [comment],
/// that has predicted comment values, however these will change in future.
///
/// The [CrowdactionCommentDto] will also be converted to a [CrowdactionComment]
/// that is yet to be created.
///
/// [Design](https://www.figma.com/file/dYFW0QF7Fg10dpSIxA3wQb/CollAction-App?node-id=2788%3A18392&t=ITOiY5y6u515JDor-4)
class CommentItem extends StatelessWidget {
  final CrowdactionComment comment;

  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TODO(isaac): Add commenter avatar
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
