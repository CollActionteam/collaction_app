import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/profile/profile.dart';
import '../badge/badge_dto.dart';

part 'profile_dto.freezed.dart';
part 'profile_dto.g.dart';

@freezed
class ProfileDto with _$ProfileDto {
  const ProfileDto._();

  const factory ProfileDto({
    required String userId,
    required String firstName,
    required String lastName,
    required String avatar,
    String? bio,
    List<BadgeDto>? badges,
  }) = _ProfileDto;

  Profile toDomain() {
    return Profile(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      bio: bio,
      badges: badges?.map((option) => option.toDomain()).toList(),
    );
  }

  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);
}
