import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../presentation/shared_widgets/secondary_chip.dart';

part 'crowdaction.freezed.dart';

@freezed
class CrowdAction with _$CrowdAction {
  const CrowdAction._();

  const factory CrowdAction({
    required String crowdactionID,
    required String title,
    required String description,
    required String category,
    required String location,
    required List<TopParticipant> topParticipants,
    required List<CommitmentOption> commitmentOptions,
    required DateTime dateStart,
    required DateTime dateEnd,
    required DateTime dateLimitJoin,
    required Images images,
    required int participantCount,
    String? passwordJoin,
    String? subCategory,
  }) = _CrowdAction;

  bool get hasParticipants => participantCount > 0;

  List<Widget> toChips() {
    return [
      SecondaryChip(text: category),
      if (subCategory != null) ...[SecondaryChip(text: subCategory ?? "")],
    ];
  }

  double avatarWidth() {
    if (topParticipants.length == 3) {
      return 100.0;
    } else if (topParticipants.length == 2) {
      return 80.0;
    } else {
      return 40.0;
    }
  }
}

@freezed
class Images with _$Images {
  const factory Images({
    required String card,
    required String banner,
  }) = _Images;
}

@freezed
class CommitmentOption with _$CommitmentOption {
  factory CommitmentOption({
    required String id,
    required String label,
    required String description,
    List<CommitmentOption>? requires,
    String? icon,
    String? ref,
  }) = _CommitmentOption;
}

@freezed
class TopParticipant with _$TopParticipant {
  factory TopParticipant({
    required String userId,
    required String name,
    String? imageUrl,
  }) = _TopParticipant;
}
