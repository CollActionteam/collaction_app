part of '../crowdaction_comments_page.dart';

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
