import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/crowdaction/paginated_crowdactions.dart';
import '../core/page_info_dto.dart';
import 'crowdaction_dto.dart';

part 'paginated_crowdactions_dto.freezed.dart';
part 'paginated_crowdactions_dto.g.dart';

@freezed
class PaginatedCrowdActionsDto with _$PaginatedCrowdActionsDto {
  const PaginatedCrowdActionsDto._();

  const factory PaginatedCrowdActionsDto({
    required List<CrowdActionDto> crowdActions,
    required PageInfoDto pageInfo,
  }) = _PaginatedCrowdActionsDto;

  factory PaginatedCrowdActionsDto.fromJson(Map<String, dynamic> json) =>
      _$PaginatedCrowdActionsDtoFromJson(json);

  PaginatedCrowdActions toDomain() => PaginatedCrowdActions(
        crowdActions: crowdActions.map((e) => e.toDomain()).toList(),
        pageInfo: pageInfo.toDomain(),
      );
}
