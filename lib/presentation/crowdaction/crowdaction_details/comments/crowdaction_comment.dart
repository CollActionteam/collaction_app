import 'package:flutter/material.dart';

import '../../../../domain/crowdaction/crowdaction_comment.dart';
import '../../../../domain/user/i_user_repository.dart';
import '../../../../domain/user/user.dart';
import '../../../../infrastructure/core/injection.dart';
import '../../../shared_widgets/user_avatar.dart';
import '../../../shared_widgets/user_display_name.dart';
import '../../../themes/constants.dart';
import '../../../utils/time.ext.dart';

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${comment.createdAt.toCommentTime()} ago",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: kPrimaryColor300,
                  fontSize: 11,
                ),
              ),
              StreamBuilder(
                stream: getIt<IUserRepository>().observeUser(),
                builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                  return Row(
                    children: [
                      UserAvatar(userId: comment.authorId),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: UserDisplayName(
                          userId: comment.authorId,
                        ),
                      ),
                      if (snapshot.data?.id == comment.authorId) ...[
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Delete",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: kAccentColor,
                              fontSize: 11,
                            ),
                          ),
                        )
                      ]
                    ],
                  );
                },
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
          child: Text(
            comment.message,
            style: const TextStyle(
              color: kPrimaryColor300,
              fontWeight: FontWeight.w300,
            ),
          ),
        )
      ],
    );
  }
}
