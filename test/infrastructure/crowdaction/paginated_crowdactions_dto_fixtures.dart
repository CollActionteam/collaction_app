import 'package:collaction_app/domain/core/page_info.dart';
import 'package:collaction_app/domain/crowdaction/paginated_crowdactions.dart';
import 'package:collaction_app/infrastructure/core/page_info_dto.dart';
import 'package:collaction_app/infrastructure/crowdaction/paginated_crowdactions_dto.dart';

final tPaginatedCrowdActions = PaginatedCrowdActions(
  crowdActions: [],
  pageInfo: PageInfo(
    page: 0,
    pageSize: 0,
    totalPages: 0,
    totalItems: 0,
  ),
);

final tPaginatedCrowdActionsDto = PaginatedCrowdActionsDto(
  crowdActions: [],
  pageInfo: PageInfoDto(
    page: 0,
    pageSize: 0,
    totalPages: 0,
    totalItems: 0,
  ),
);

final tPaginatedCrowdActionsJson = {
  "crowdActions": [],
  "pageInfo": {
    "page": 0,
    "pageSize": 0,
    "totalPages": 0,
    "totalItems": 0,
  },
};
