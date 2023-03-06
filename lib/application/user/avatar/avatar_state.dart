part of 'avatar_bloc.dart';

abstract class AvatarState {
  const AvatarState();
  
  const factory AvatarState.initial() = _Initial;
  const factory AvatarState.uploading() = _Uploading;
  const factory AvatarState.uploadSuccess() = _UploadSuccess;
  const factory AvatarState.uploadFailed() = _UploadFailed;
}

class _Initial extends AvatarState {
  const _Initial();
}

class _Uploading extends AvatarState {
  const _Uploading();
}

class _UploadSuccess extends AvatarState {
  const _UploadSuccess();
}

class _UploadFailed extends AvatarState {
  const _UploadFailed();
}
