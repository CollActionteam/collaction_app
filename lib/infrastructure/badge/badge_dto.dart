import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/badge/badge.dart';

part 'badge_dto.freezed.dart';

part 'badge_dto.g.dart';

@freezed
class BadgeDto with _$BadgeDto {
  const BadgeDto._();

  factory BadgeDto({
    required BadgeTierEnum tier,
    required AwardTypeEnum awardType,
    required int minimumCheckIns,
  }) = _BadgeDto;

  Badge toDomain() {
    return Badge(
      tier: tier,
      awardType: awardType,
      minimumCheckIns: minimumCheckIns,
    );
  }

  factory BadgeDto.fromJson(Map<String, dynamic> json) =>
      _$BadgeDtoFromJson(json);
}
