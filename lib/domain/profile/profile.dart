import 'package:freezed_annotation/freezed_annotation.dart';

import '../badge/badge.dart';

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
    List<Badge>? badges,
  }) = _Profile;

  String get fullName => '$firstName $lastName';
}
