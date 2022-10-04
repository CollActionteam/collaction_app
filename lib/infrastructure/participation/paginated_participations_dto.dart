import 'package:collaction_app/domain/participation/paginated_participations.dart';
import 'package:collaction_app/infrastructure/participation/participation_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_participations_dto.freezed.dart';
part 'paginated_participations_dto.g.dart';

@freezed
class PageInfoDto with _$PageInfoDto {
  const PageInfoDto._();

  const factory PageInfoDto({
    required int page,
    required int pageSize,
    required int totalPages,
    required int totalItems,
  }) = _PageInfoDto;

  factory PageInfoDto.fromJson(Map<String, dynamic> json) =>
      _$PageInfoDtoFromJson(json);

  PageInfo toDomain() => PageInfo(
        page: page,
        pageSize: pageSize,
        totalPages: totalPages,
        totalItems: totalItems,
      );
}

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
