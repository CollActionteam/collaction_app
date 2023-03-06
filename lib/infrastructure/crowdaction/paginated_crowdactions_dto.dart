import 'package:equatable/equatable.dart';

import '../../domain/crowdaction/paginated_crowdactions.dart';
import '../core/page_info_dto.dart';
import 'crowdaction_dto.dart';

class PaginatedCrowdActionsDto extends Equatable {
  const PaginatedCrowdActionsDto({
    required this.crowdActions,
    required this.pageInfo,
  });

  PaginatedCrowdActions toDomain() => PaginatedCrowdActions(
        crowdActions: crowdActions.map((e) => e.toDomain()).toList(),
        pageInfo: pageInfo.toDomain(),
      );

  factory PaginatedCrowdActionsDto.fromJson(Map<String, dynamic> json) =>
      PaginatedCrowdActionsDto(
        crowdActions: (json['crowdActions'] as List<dynamic>)
            .map((dynamic e) =>
                CrowdActionDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        pageInfo:
            PageInfoDto.fromJson(json['pageInfo'] as Map<String, dynamic>),
      );

  final List<CrowdActionDto> crowdActions;

  final PageInfoDto pageInfo;

  PaginatedCrowdActionsDto copyWith({
    List<CrowdActionDto>? crowdActions,
    PageInfoDto? pageInfo,
  }) {
    return PaginatedCrowdActionsDto(
      crowdActions: crowdActions ?? this.crowdActions,
      pageInfo: pageInfo ?? this.pageInfo,
    );
  }

  @override
  List<Object?> get props => [
        crowdActions,
        pageInfo,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'crowdActions': crowdActions,
        'pageInfo': pageInfo,
      };
}
