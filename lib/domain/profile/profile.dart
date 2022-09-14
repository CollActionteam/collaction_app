import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';

@freezed
class Profile with _$Profile {
  const Profile._();

  const factory Profile({
    required String userId,
    required String firstName,
    required String lastName,
    required String avatar,
    String? bio,
  }) = _Profile;
}
