import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_failures.freezed.dart';

@freezed
class UploadPathFailure with _$UploadPathFailure {
  const factory UploadPathFailure.unexpected() = Unexpected;
}

@freezed
class UploadFailure with _$UploadFailure {
  const factory UploadFailure.uploadFailed() = UploadFailed;
}
