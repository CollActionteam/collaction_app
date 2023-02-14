import 'package:flutter/material.dart';

import '../../themes/constants.dart';
import 'avatar_info.dart';

class UserInfoAndAvatar extends StatelessWidget {
  final String? pictureUrl;

  final String? name;

  const UserInfoAndAvatar({Key? key, this.pictureUrl, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: avatarInfoDecorationBox,
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          top: 10,
          bottom: 10,
          right: 25.5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AvatarAndInfo(
              pictureUrl: pictureUrl,
              name: name,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.settings,
                    color: kPrimaryColor600,
                    size: 21,
                  ),
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
