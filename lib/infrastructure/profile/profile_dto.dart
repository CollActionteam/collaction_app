import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/profile/profile.dart';
import '../core/location_dto.dart';

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
    required LocationDto location,
    String? bio,
  }) = _ProfileDto;

  Profile toDomain() {
    return Profile(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      bio: bio,
      location: location.toDomain(),
    );
  }

  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);
}
