import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/crowdaction/crowdaction.dart';
import '../../domain/profile/profile.dart';
import '../../domain/user/i_profile_repository.dart';
import '../../domain/user/profile_failure.dart';
import '../../infrastructure/core/injection.dart';

/// Show a user's avatar photo from the user's profile
///
/// If user has no photo, use an avatar with first letter of their display name
class UserAvatar extends StatelessWidget {
  /// The [userId] from the user's profile,
  /// this can be from a [CrowdActionComment] or [CrowdAction.topParticipants]
  final String userId;

  /// The Avatar radius
  final double radius;

  const UserAvatar({Key? key, required this.userId, this.radius = 18})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Either<ProfileFailure, Profile>>(
      stream: getIt<IProfileRepository>().getUserProfileById(userId),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data?.isRight() == true) {
          final profile = snapshot.data?.fold((l) => null, id);
          return CircleAvatar(
            radius: radius,
            backgroundColor: Colors.grey[300],
            backgroundImage: profile?.photoUrl != null
                ? NetworkImage(
                    profile?.photoUrl ?? "",
                  )
                : null,
            child: Container(
              color: Colors.grey[300],
              child: Text(
                (profile?.displayname.toUpperCase() ?? "A")[0],
              ),
            ),
          );
        } else {
          return Shimmer.fromColors(
            baseColor: kSecondaryTransparent,
            highlightColor: kAlmostTransparent,
            child: Container(
              height: radius * 2,
              width: radius * 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius * 2),
                color: kSecondaryTransparent,
              ),
            ),
          );
        }
      },
    );
  }
}
