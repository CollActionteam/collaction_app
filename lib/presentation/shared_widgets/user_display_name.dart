import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/crowdaction/crowdaction.dart';
import '../../domain/profile/profile.dart';
import '../../domain/user/i_profile_repository.dart';
import '../../domain/user/profile_failure.dart';
import '../../infrastructure/core/injection.dart';
import '../themes/constants.dart';

/// Show a user's display name from the user's profile
class UserDisplayName extends StatelessWidget {
  /// The [userId] from the user's profile,
  /// this can be from a [CrowdActionComment] or [CrowdAction.topParticipants]
  final String userId;

  const UserDisplayName({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Either<ProfileFailure, Profile>>(
      stream: getIt<IProfileRepository>().getUserProfileById(userId),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data?.isRight() == true) {
          final profile = snapshot.data?.fold((l) => null, id);
          return Text(
            profile?.displayname ?? "",
            style: const TextStyle(
              color: kPrimaryColor400,
              fontWeight: FontWeight.w300,
            ),
          );
        } else {
          return Shimmer.fromColors(
            baseColor: kSecondaryTransparent,
            highlightColor: kAlmostTransparent,
            child: Container(
              height: 17,
              color: kSecondaryTransparent,
              width: MediaQuery.of(context).size.width / 3,
            ),
          );
        }
      },
    );
  }
}
