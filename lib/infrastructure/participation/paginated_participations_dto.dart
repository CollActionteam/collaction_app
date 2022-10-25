import 'package:collaction_app/domain/participation/paginated_participations.dart';
import 'package:collaction_app/infrastructure/participation/participation_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/page_info_dto.dart';

part 'paginated_participations_dto.g.dart';
part 'paginated_participations_dto.freezed.dart';

@freezed
class PaginatedParticipationsDto with _$PaginatedParticipationsDto {
  const PaginatedParticipationsDto._();

  const factory PaginatedParticipationsDto({
    required List<ParticipationDto> participations,
    required PageInfoDto pageInfo,
  }) = _PaginatedParticipationsDto;

  factory PaginatedParticipationsDto.fromJson(Map<String, dynamic> json) =>
      _$PaginatedParticipationsDtoFromJson(json);

  PaginatedParticipations toDomain() => PaginatedParticipations(
        participations: participations.map((e) => e.toDomain()).toList(),
        pageInfo: pageInfo.toDomain(),
      );
}
