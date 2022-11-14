part of '../crowdaction_comments_page.dart';

/// A list of all actions that can be displayed about or done on a comment.
///
/// These include:-
///  - The comment date can be Today or the yyyy-mm-dd formatted date
///  of the comment. (TODO: The date formatting isn't yet confirmed from design)
///  - The number of likes, this displays the like count only when it's 1 or more.
///  - Reply option, this requests focus to the comment text field, keeping a
///  record of which comment is being responded to.
///  - Flag option [CollactionIcons.flag] when not flagged and
///  [CollactionIcons.flag_filled] when the issue is flagged.
///  (TODO: Functionality flow is also unconfirmed)
///  - Like, which displays [CollactionIcons.heart] when a comment is not yet
///  liked by the current user and [CollactionIcons.heart_filled] in [Colors.red]
///  when the current user has liked the comment.
///  - Delete, this replaces Like when the current user is the comment author.
///  It displays a [CollactionIcons.trash] and when tapped asks confirmation
///  before deleting comment.
///
/// [Design](https://www.figma.com/file/dYFW0QF7Fg10dpSIxA3wQb/CollAction-App?node-id=2788%3A18234&t=ITOiY5y6u515JDor-4)
class CommentActions extends StatelessWidget {
  final CrowdactionCommentDto comment;

  const CommentActions({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 15),
        Text('Today', style: _textStyle),
        if (comment.likes > 0) ...[
          ..._dot,
          Text(
            '${comment.likes} like${comment.likes > 1 ? 's' : ''}',
            style: _textStyle,
          )
        ],
        ..._dot,
        Text('Reply', style: _textStyle),
        ..._dot,
        Icon(
          comment.flagged == true
              ? CollactionIcons.flag_filled
              : CollactionIcons.flag,
          size: 14,
        ),
        const Spacer(),
        Icon(
          comment.likedByMe
              ? CollactionIcons.heart_filled
              : CollactionIcons.heart,
          color: comment.likedByMe ? Colors.redAccent : null,
          size: 14,
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}

final _textStyle = const TextStyle(fontSize: 11).withLineHeight(13);
final List<Widget> _dot = [
  const SizedBox(width: 10),
  Text("⋅", style: _textStyle),
  const SizedBox(width: 10),
];
