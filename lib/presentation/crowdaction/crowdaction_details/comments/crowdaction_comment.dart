import 'package:collaction_app/presentation/core/collaction_icons.dart';
import 'package:collaction_app/presentation/shared_widgets/expandable_text.dart';
import 'package:flutter/material.dart';

import '../../../../domain/crowdaction/crowdaction_comment.dart';
import '../../../../domain/user/i_user_repository.dart';
import '../../../../domain/user/user.dart';
import '../../../../infrastructure/core/injection.dart';
import '../../../shared_widgets/user_avatar.dart';
import '../../../shared_widgets/user_display_name.dart';
import '../../../themes/constants.dart';
import '../../../utils/time.ext.dart';
import 'config.dart';

/// Display a user's comment on a crowd action
///
/// Personal comments allow for deleting
class CrowdActionUserComment extends StatelessWidget {
  /// Creates a user's comment display.
  ///
  /// The [CrowdActionComment] is passed and used to render display.
  final CrowdActionComment comment;

  const CrowdActionUserComment({Key? key, required this.comment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getIt<IUserRepository>().observeUser(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  UserAvatar(userId: comment.authorId),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: UserDisplayName(
                      userId: comment.authorId,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: kAlmostTransparent,
              ),
              child: ExpandableText(
                comment.message,
                trimLines: 6,
                style: const TextStyle(
                  color: kPrimaryColor300,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          "${comment.createdAt.toCommentTime()} ago",
                          style: subCommentStyle,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (comment.hasLikes) ...[
                          Text(
                            "•",
                            style: subCommentStyle.copyWith(fontSize: 18),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            comment.likesText,
                            style: subCommentStyle,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                        Text(
                          "•",
                          style: subCommentStyle.copyWith(fontSize: 18),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero, // Set this
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                            ), // and this
                          ),
                          child: Text(
                            "Reply",
                            style: subCommentStyle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            // TODO -If not participating, prompt participation
                            // TODO - Reply to comment
                          },
                        ),
                        Text(
                          "•",
                          style: subCommentStyle.copyWith(fontSize: 18),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(CollactionIcons.flag),
                            iconSize: 15,
                            onPressed: () {
                              // TODO -If not participating, prompt participation
                              // TODO - Reply to comment
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  if (snapshot.data?.id == comment.authorId) ...[
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(CollactionIcons.trash),
                        iconSize: 15,
                        onPressed: () {
                          // TODO - Delete CrowdAction
                        },
                      ),
                    )
                  ] else ...[
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(CollactionIcons.heart),
                        iconSize: 15,
                        onPressed: () {
                          // TODO -If not participating, prompt participation
                          // TODO - Like CrowdAction
                        },
                      ),
                    )
                  ]
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
