import 'dart:io';

import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final File? image;
  final String? profileImage;
  final double maxRadius;

  const ProfilePicture({
    this.image,
    this.profileImage,
    required this.maxRadius,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;
    if (image != null) {
      // ignore: unnecessary_cast
      imageProvider = FileImage(image!) as ImageProvider<Object>;
    } else if (profileImage != null) {
      imageProvider = NetworkImage(
        profileImage!,
      );
    }

    return CircleAvatar(
      maxRadius: maxRadius,
      foregroundImage: imageProvider,
      backgroundImage: const AssetImage(
        'assets/images/default_avatar.png',
      ),
      backgroundColor: Colors.transparent,
      child: const SizedBox.shrink(),
      onForegroundImageError: (_, __) {},
    );
  }
}
