
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../domain/user/i_user_repository.dart';
import '../../../domain/user/user.dart';
import '../../../infrastructure/core/injection.dart';
import '../../profile/widget/profile_picture.dart';
import '../../themes/constants.dart';

class AvatarAndInfo extends StatefulWidget {
  final String? pictureUrl;
  final String? name;

  const AvatarAndInfo(
      {Key? key,
      required this.pictureUrl,
      required this.name,
      })
      : super(key: key);

  @override
  State<AvatarAndInfo> createState() => _AvatarAndInfoState();
}

class _AvatarAndInfoState extends State<AvatarAndInfo> {
  late final IUserRepository _userRepository;
  File? _image;
  @override
  void initState() {
    super.initState();
    _userRepository = getIt<IUserRepository>();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ProfilePicture(
        //   maxRadius: 40,
        //   profileImage:
        //       '${dotenv.get('BASE_STATIC_ENDPOINT_URL')}/${widget.pictureUrl}',
        // ),
        ProfilePicture(
          image: _image,
          profileImage: widget.pictureUrl !=
              null
              ? '${dotenv.get('BASE_STATIC_ENDPOINT_URL')}/${widget.pictureUrl}'
              : null,
          maxRadius: 50,
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name ?? "",
              style: nameTextStyle,
            ),
            StreamBuilder(builder: (context, AsyncSnapshot<User> snapshot) {
              if (snapshot.hasData) {
                final number = snapshot.data!.phoneNumber ?? 'no phone number';
                return Text(
                  number,
                  style: phoneNumberTextStyle,
                );
              } else {
                return const Text('...');
              }

            },stream:     _userRepository.observeUser()
    ,),
          ],
        )
      ],
    );
  }
}
