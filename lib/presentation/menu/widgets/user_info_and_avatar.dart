import 'package:flutter/material.dart';

import '../../themes/constants.dart';
import 'avatar_info.dart';

class UserInfoAndAvatar extends StatelessWidget {
  final String? avatar;
  final String fullName;

  const UserInfoAndAvatar({
    Key? key,
    this.avatar,
    required this.fullName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: kAlmostTransparent,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            AvatarAndInfo(
              avatar: avatar,
              phoneNumber: '+31 612345678',
              fullName: fullName,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                // TODO: Open Settings Page
              },
              child: Container(
                height: 36,
                width: 36,
                child: Icon(
                  Icons.settings,
                  color: kPrimaryColor600,
                  size: 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
