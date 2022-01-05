import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';

@freezed
class Profile with _$Profile {
  const Profile._();

  const factory Profile({
    String? bio,
  }) = _Profile;
}
