import 'package:freezed_annotation/freezed_annotation.dart';

part 'badge.freezed.dart';

@freezed
class CollActionBadge with _$CollActionBadge {
  const CollActionBadge._();

  const factory CollActionBadge({
    required BadgeTierEnum tier,
    required AwardTypeEnum awardType,
    required int minimumCheckIns,
  }) = _CollActionBadge;
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
