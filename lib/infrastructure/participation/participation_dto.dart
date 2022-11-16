import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/participation/participation.dart';

part 'participation_dto.freezed.dart';
part 'participation_dto.g.dart';

@freezed
class ParticipationDto with _$ParticipationDto {
  const ParticipationDto._();

  factory ParticipationDto({
    required String id,
    required String crowdActionId,
    required String userId,
    required String fullName,
    required String avatar,
    required List<String> commitmentOptions,
    required String joinDate,
    required int dailyCheckIns,
  }) = _ParticipationDto;

  Participation toDomain() {
    return Participation(
      id: id,
      crowdActionId: crowdActionId,
      userId: userId,
      fullName: fullName,
      avatar: avatar,
      commitmentOptions: commitmentOptions,
      joinDate: DateTime.parse(joinDate),
      dailyCheckIns: dailyCheckIns,
    );
  }

  factory ParticipationDto.fromJson(Map<String, dynamic> json) =>
      _$ParticipationDtoFromJson(json);
}
