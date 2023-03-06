import 'package:equatable/equatable.dart';

import '../core/page_info.dart';
import 'crowdaction.dart';

class PaginatedCrowdActions extends Equatable {
  const PaginatedCrowdActions({
    required this.crowdActions,
    required this.pageInfo,
  });

  factory PaginatedCrowdActions.fromJson(Map<String, dynamic> json) =>
      PaginatedCrowdActions(
        crowdActions: (json['crowdActions'] as List<dynamic>)
            .map((dynamic e) => CrowdAction.fromJson(e as Map<String, dynamic>))
            .toList(),
        pageInfo: PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      );

  final List<CrowdAction> crowdActions;

  final PageInfo pageInfo;

  PaginatedCrowdActions copyWith({
    List<CrowdAction>? crowdActions,
    PageInfo? pageInfo,
  }) {
    return PaginatedCrowdActions(
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
        'crowdActions': crowdActions.map((e) => e.toJson()),
        'pageInfo': pageInfo.toJson(),
      };
}
