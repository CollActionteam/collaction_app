import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/profile/profile.dart';

part 'profile_dto.freezed.dart';
part 'profile_dto.g.dart';

@freezed
class ProfileDto with _$ProfileDto {
  const ProfileDto._();

  const factory ProfileDto({
    String? bio,
  }) = _ProfileDto;

  Profile toDomain() {
    return Profile(
      bio: bio,
    );
  }

  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);
}
