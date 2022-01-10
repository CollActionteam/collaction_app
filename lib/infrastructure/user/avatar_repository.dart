import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart';
import 'package:injectable/injectable.dart';

import '../../domain/auth/errors.dart';
import '../../domain/auth/i_auth_repository.dart';
import '../../domain/user/i_avatar_repository.dart';
import '../../domain/user/upload_failures.dart';

@LazySingleton(as: IAvatarRepository)
class AvatarRepository implements IAvatarRepository, Disposable {
  final http.Client _client;
  final IAuthRepository _authRepository;
  const AvatarRepository(this._client, this._authRepository);

  @override
  Future<Either<UploadPathFailure, Uri>> getAvatarUploadPath() async {
    try {
      final user = (await _authRepository.getSignedInUser())
          .getOrElse(() => throw NotAuthenticatedError());
      final tokenId = await user.getIdToken();

      final response = await _client.get(
        Uri.parse(
          '${dotenv.env['BASE_API_ENDPOINT_URL']}/upload-profile-picture',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokenId'
        },
      );

      /// TODO: Consider implementing simple DTO
      final uploadUrl = (json.decode(response.body)
          as Map<String, dynamic>)['upload_url'] as String;

      return right(Uri.parse(uploadUrl));
    } catch (_) {
      return left(const UploadPathFailure.unexpected());
    }
  }

  @override
  Future<Either<UploadFailure, Unit>> uploadAvatar(
    File imageFile,
    Uri uri,
  ) async {
    try {
      final imageBytes = await imageFile.readAsBytes();
      final resizedImage = copyResize(decodeImage(imageBytes)!, width: 300);
      final resizedBytes = encodePng(resizedImage);
      final response = await _client.put(
        uri,
        body: resizedBytes,
      );

      if (response.statusCode == 200) {
        return right(unit);
      } else {
        return left(const UploadFailure.uploadFailed());
      }
    } catch (_) {
      return left(const UploadFailure.uploadFailed());
    }
  }

  @override
  FutureOr onDispose() {
    // TODO: implement onDispose
    throw UnimplementedError();
  }
}
