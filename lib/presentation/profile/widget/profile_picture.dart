import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
      imageProvider = FileImage(image!);
    }

    if (profileImage != null && imageProvider == null) {
      imageProvider = NetworkImage(
        "${dotenv.env['BASE_STATIC_ENDPOINT_URL']}/$profileImage",
      );
    }

    imageProvider ??= const AssetImage(
      'assets/images/default_avatar.png',
    );

    return CircleAvatar(
      maxRadius: maxRadius,
      foregroundImage: imageProvider,
      backgroundImage: const AssetImage(
        'assets/images/default_avatar.png',
      ),
      onForegroundImageError: (_, __) {},
    );
  }
}
