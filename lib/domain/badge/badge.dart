import 'package:freezed_annotation/freezed_annotation.dart';

part 'badge.freezed.dart';

@freezed
class Badge with _$Badge {
  const Badge._();

  const factory Badge({
    required BadgeTierEnum tier,
    required AwardTypeEnum awardType,
    required int minimumCheckIns,
  }) = _Badge;
}

enum BadgeTierEnum {
  @JsonValue('BRONZE')
  bronze,
  @JsonValue('SILVER')
  silver,
  @JsonValue('GOLD')
  gold,
  @JsonValue('DIAMOND')
  diamond,
}

enum AwardTypeEnum {
  @JsonValue('ALL')
  all,
  @JsonValue('TIER')
  tier,
}
