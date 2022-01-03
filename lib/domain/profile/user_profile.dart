import 'package:freezed_annotation/freezed_annotation.dart';

import '../user/user.dart';
import 'profile.dart';

part 'user_profile.freezed.dart';

@freezed
class UserProfile with _$UserProfile {
  const UserProfile._();

  const factory UserProfile({
    required User user,
    required Profile profile,
  }) = _UserProfile;
}
