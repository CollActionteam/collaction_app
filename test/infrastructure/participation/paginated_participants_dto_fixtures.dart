import 'package:collaction_app/domain/participation/paginated_participations.dart';
import 'package:collaction_app/domain/core/page_info.dart';
import 'package:collaction_app/infrastructure/core/page_info_dto.dart';
import 'package:collaction_app/infrastructure/participation/paginated_participations_dto.dart';

final tPaginatedParticipants = PaginatedParticipations(
  participations: [],
  pageInfo: PageInfo(
    page: 0,
    pageSize: 0,
    totalPages: 0,
    totalItems: 0,
  ),
);

final tPaginatedParticipantsDto = PaginatedParticipationsDto(
  participations: [],
  pageInfo: PageInfoDto(
    page: 0,
    pageSize: 0,
    totalPages: 0,
    totalItems: 0,
  ),
);

final tPaginatedParticipantsJson = {
  "participations": [],
  "pageInfo": {
    "page": 0,
    "pageSize": 0,
    "totalPages": 0,
    "totalItems": 0,
  },
};
