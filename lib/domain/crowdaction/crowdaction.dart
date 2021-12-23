import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../presentation/shared_widgets/secondary_chip.dart';

part 'crowdaction.freezed.dart';

@freezed
class CrowdAction with _$CrowdAction {
  const factory CrowdAction({
    required String name,
    required String description,
    required DateTime start,
    required DateTime end,
    // TODO: Review GraphQL
    // required String title,
    // required String subtitle,
    // required String description,
    String? image, // TODO - Request backend to add this
    required int numParticipants,
    // required int participantsGoal,
    // DateTime? startDate,
    // DateTime? endDate,
    String? category,
    String? subCategory,
  }) = _CrowdAction;

  List<Widget> toChips() {
    return [
      if (category != null) ...[SecondaryChip(text: category ?? "")],
      if (subCategory != null) ...[SecondaryChip(text: subCategory ?? "")],
    ];
  }
}
