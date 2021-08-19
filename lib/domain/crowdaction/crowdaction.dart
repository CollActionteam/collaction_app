import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowdaction.freezed.dart';

@freezed
abstract class CrowdAction implements _$CrowdAction {
  const factory CrowdAction({
    required String name,
    required String description,
    required DateTime start,
    required DateTime end,
    // TODO: Review GraphQL
    // required String title,
    // required String subtitle,
    // required String description,
    // required int numParticipants,
    // required int participantsGoal,
    // DateTime? startDate,
    // DateTime? endDate,
    // List<String>? tags,
  }) = _CrowdAction;
}
