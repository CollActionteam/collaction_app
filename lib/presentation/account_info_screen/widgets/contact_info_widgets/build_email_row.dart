import '../../../../application/user/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../themes/constants.dart';

class BuildEmailRow extends StatelessWidget {
  const BuildEmailRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        String? email = "jane.alfred98@gmail.com";
        return Column(
          children: [
            SizedBox(
              height: 33,
              child: Row(
                children: [
                  Text(
                    email ?? "No email",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: kPrimaryColor300,
                          fontFamily: 'Rubik',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Spacer(),
                  email != null
                      ? TextButton(
                          onPressed: () {},
                          child: Text(
                            "Change",
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: kAccentColor,
                                      fontFamily: 'Rubik',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ))
                      : TextButton(
                          onPressed: () {},
                          child: Text(
                            "Add",
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: kAccentColor,
                                      fontFamily: 'Rubik',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                          )),
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
