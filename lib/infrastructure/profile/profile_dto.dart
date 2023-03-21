import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/crowdaction/crowdaction.dart';
import '../../domain/profile/profile.dart';

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
    required Location location,
    String? bio,
  }) = _ProfileDto;

  Profile toDomain() {
    return Profile(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      bio: bio,
      location: location,
    );
  }

  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);
}
