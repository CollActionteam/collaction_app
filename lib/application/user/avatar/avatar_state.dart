part of 'avatar_bloc.dart';

@freezed
class AvatarState with _$AvatarState {
  const factory AvatarState.initial() = _Initial;
  const factory AvatarState.uploading() = _Uploading;
  const factory AvatarState.uploadSuccess() = _UploadSuccess;
  const factory AvatarState.uploadFailed() = _UploadFailed;
}
