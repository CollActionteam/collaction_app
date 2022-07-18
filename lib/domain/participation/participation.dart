import 'package:freezed_annotation/freezed_annotation.dart';

part 'participation.freezed.dart';

@freezed
class Participation with _$Participation {
  const Participation._();

  const factory Participation({
    required String id,
    required String crowdActionId,
    required String userId,
    required List<String> commitmentOptions,
    required DateTime joinDate,
    required int dailyCheckIns,
  }) = _Participation;
}
