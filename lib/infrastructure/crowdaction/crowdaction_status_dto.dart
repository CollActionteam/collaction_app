// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowdaction_status_dto.freezed.dart';
part 'crowdaction_status_dto.g.dart';

@freezed
class CrowdActionStatusDto with _$CrowdActionStatusDto {
  const CrowdActionStatusDto._();

  factory CrowdActionStatusDto({
    @JsonKey(name: 'userID') required String userId,
    @JsonKey(name: 'crowdactionID') required String crowdActionId,
    required String name,
    required String title,
    required String date,
    required List<String> commitments,
  }) = _CrowdActionStatusDto;

  factory CrowdActionStatusDto.fromJson(Map<String, dynamic> json) =>
      _$CrowdActionStatusDtoFromJson(json);
}
