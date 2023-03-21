import 'package:freezed_annotation/freezed_annotation.dart';

import '../crowdaction/crowdaction.dart';

part 'profile.freezed.dart';

@freezed
class Profile with _$Profile {
  const Profile._();

  const factory Profile({
    required String userId,
    required String firstName,
    required String lastName,
    required String avatar,
    required Location location,
    String? bio,
  }) = _Profile;

  String get fullName => '$firstName $lastName';
}
