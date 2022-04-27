import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:dartz/dartz.dart';
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
  final ISettingsRepository _settingsRepository;

  const AvatarRepository(
    this._client,
    this._authRepository,
    this._settingsRepository,
  );

  @override
  Future<Either<UploadPathFailure, Uri>> getAvatarUploadPath() async {
    try {
      final user = (await _authRepository.getSignedInUser())
          .getOrElse(() => throw NotAuthenticatedError());
      final tokenId = await user.getIdToken();

      final response = await _client.get(
        Uri.parse(
          '${await _settingsRepository.baseApiEndpointUrl}/upload-profile-picture',
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
    _client.close();
  }
}
