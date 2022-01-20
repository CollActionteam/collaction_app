import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';

@freezed
class Profile with _$Profile {
  const Profile._();

  const factory Profile({
    String? bio,
    required String phone,
    required String userid,
    required String displayname,
    String? country,
    String? city,
    String? photoUrl,
  }) = _Profile;
}
