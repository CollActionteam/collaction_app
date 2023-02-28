import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/core.dart';

part 'participation.freezed.dart';

@freezed
class Participation with _$Participation {
  const Participation._();

  const factory Participation({
    required String id,
    required String crowdActionId,
    required String fullName,
    required String avatar,
    required String userId,
    required List<String> commitments,
    required DateTime joinDate,
    required int dailyCheckIns,
  }) = _Participation;

  // Participation avatar url
  String get avatarUrl => '$baseStaticUrl/$avatar';
}
