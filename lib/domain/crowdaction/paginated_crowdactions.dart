import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/page_info.dart';
import 'crowdaction.dart';

part 'paginated_crowdactions.freezed.dart';

@freezed
class PaginatedCrowdActions with _$PaginatedCrowdActions {
  const PaginatedCrowdActions._();

  const factory PaginatedCrowdActions({
    required List<CrowdAction> crowdActions,
    required PageInfo pageInfo,
  }) = _PaginatedCrowdActions;
}
