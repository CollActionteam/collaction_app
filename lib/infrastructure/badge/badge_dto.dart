import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/badge/badge.dart';

part 'badge_dto.freezed.dart';

part 'badge_dto.g.dart';

@freezed
class CollActionBadgeDto with _$CollActionBadgeDto {
  const CollActionBadgeDto._();

  factory CollActionBadgeDto({
    required BadgeTierEnum tier,
    required AwardTypeEnum awardType,
    required int minimumCheckIns,
  }) = _CollActionBadgeDto;

  CollActionBadge toDomain() {
    return CollActionBadge(
      tier: tier,
      awardType: awardType,
      minimumCheckIns: minimumCheckIns,
    );
  }

  factory CollActionBadgeDto.fromJson(Map<String, dynamic> json) =>
      _$CollActionBadgeDtoFromJson(json);
}
