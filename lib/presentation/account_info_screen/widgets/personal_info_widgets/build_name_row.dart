import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/user/profile/profile_bloc.dart';

import '../../../themes/constants.dart';
import 'package:flutter/material.dart';

import 'change_name_dialog.dart';

class BuildNameRow extends StatelessWidget {
  BuildNameRow({super.key, r});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        String name = state.userProfile?.profile.firstName ?? "You";
        return Column(
          children: [
            SizedBox(
              height: 33,
              child: Row(
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: kPrimaryColor300,
                          fontFamily: 'Rubik',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Spacer(),
                  ChangeNameDialog(
                    firstName:
                        state.userProfile?.profile.firstName ?? "Firstname",
                    lastName: state.userProfile?.profile.lastName ?? "Lastname",
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      "Your full name is displayed on your profile, when you participate in crowdactions, and when participating in the community.",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: kPrimaryColor300,
                            fontFamily: 'Rubik',
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
