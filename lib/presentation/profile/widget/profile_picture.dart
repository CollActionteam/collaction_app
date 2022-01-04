import 'dart:io';

import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key? key,
    File? image,
    String? userId,
    required double maxRadius,
  })  : _image = image,
        _userId = userId,
        _maxRadius = maxRadius,
        super(key: key);

  final File? _image;
  final String? _userId;
  final double _maxRadius;

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;
    if (_image != null) {
      // ignore: unnecessary_cast
      imageProvider = FileImage(_image!) as ImageProvider<Object>;
    } else if (_userId != null) {
      imageProvider = NetworkImage(
        'https://static-dev.collaction.org/profile-pictures/$_userId.png',
      );
    }

    return CircleAvatar(
      maxRadius: _maxRadius,
      foregroundImage: imageProvider,
      backgroundImage: const AssetImage(
        'assets/images/default_avatar.png',
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
