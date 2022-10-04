import 'package:collaction_app/domain/participation/participation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_participations.freezed.dart';

@freezed
class PageInfo with _$PageInfo {
  const PageInfo._();

  const factory PageInfo({
    required int page,
    required int pageSize,
    required int totalPages,
    required int totalItems,
  }) = _PageInfo;
}

@freezed
class PaginatedParticipations with _$PaginatedParticipations {
  const PaginatedParticipations._();

  const factory PaginatedParticipations({
    required List<Participation> participations,
    required PageInfo pageInfo,
  }) = _PaginatedParticipations;
}
