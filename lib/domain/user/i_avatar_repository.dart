import 'dart:io';

import 'package:dartz/dartz.dart';

import 'upload_failures.dart';

abstract class IAvatarRepository {
  Future<Either<UploadPathFailure, Uri>> getAvatarUploadPath();
  Future<Either<UploadFailure, Unit>> uploadAvatar(File image, Uri uri);
}
