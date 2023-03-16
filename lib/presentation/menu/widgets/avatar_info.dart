import 'package:flutter/material.dart';

import '../../profile/widget/profile_picture.dart';
import '../../themes/constants.dart';

class AvatarAndInfo extends StatelessWidget {
  final String fullName;
  final String phoneNumber;
  final String? avatar;

  const AvatarAndInfo({
    required this.fullName,
    required this.phoneNumber,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfilePicture(
          profileImage: avatar,
          maxRadius: 32.5,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fullName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: kPrimaryColor400,
              ),
            ),
            const SizedBox(height: 5),
            // TODO: Use Profile, not firebase?
            Text(
              phoneNumber,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: kPrimaryColor300,
              ),
            ),
          ],
        )
      ],
    );
  }
}
