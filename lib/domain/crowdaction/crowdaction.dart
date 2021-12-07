import 'package:collaction_app/infrastructure/crowdaction/crowdaction_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowdaction.freezed.dart';

@freezed
class CrowdAction with _$CrowdAction {
  const factory CrowdAction({
    required String crowdActionId,
    required String title,
    required String description,
    required String category,
    String? subCategory,
    required String location,
    required DateTime start,
    required DateTime end,
    required DateTime dateLimitJoin,
    String? passwordJoin,
    required List<CommitmentOption> commitmentOptions,
    required List<TopParticipant> topParticipants,
    required int totalParticipants,
    required CrowdActionImages images,
  }) = _CrowdAction;
}
