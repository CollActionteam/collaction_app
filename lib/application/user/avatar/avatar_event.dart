part of 'avatar_bloc.dart';

abstract class AvatarEvent extends Equatable {
  const AvatarEvent();

  const factory AvatarEvent.started() = _Started;
  const factory AvatarEvent.uploadAvatar(File image) = _UploadAvatar;

  @override
  List<Object?> get props => [];
}

class _Started extends AvatarEvent {
  const _Started();
}

class _UploadAvatar extends AvatarEvent {
  final File image;

  const _UploadAvatar(this.image);

  @override
  List<Object?> get props => [image];
}
