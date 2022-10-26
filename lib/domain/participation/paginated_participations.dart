import 'package:collaction_app/domain/participation/participation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/page_info.dart';

part 'paginated_participations.freezed.dart';

@freezed
class PaginatedParticipations with _$PaginatedParticipations {
  const PaginatedParticipations._();

  const factory PaginatedParticipations({
    required List<Participation> participations,
    required PageInfo pageInfo,
  }) = _PaginatedParticipations;
}
