import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/core.dart';
import '../../presentation/core/collaction_icons.dart';
import '../../presentation/core/ionicons_utils.dart';
import '../../presentation/shared_widgets/secondary_chip.dart';

part 'crowdaction.freezed.dart';

@freezed
class CrowdAction with _$CrowdAction {
  const CrowdAction._();

  const factory CrowdAction({
    required String id,
    required String title,
    required String description,
    required String category,
    required Location location,
    required List<Commitment> commitments,
    required Images images,
    required int participantCount,
    required Status status,
    required JoinStatus joinStatus,
    required DateTime endAt,
    String? password,
    String? subcategory,
  }) = _CrowdAction;

  bool get hasParticipants => participantCount > 0;

  bool get hasPassword => password != null && password!.isNotEmpty;

  List<Widget> toChips() {
    return [
      SecondaryChip(text: category),
      if (subcategory != null) ...[SecondaryChip(text: subcategory!)],
    ];
  }

  bool get isOpen => joinStatus == JoinStatus.open;
  bool get isRunning => status == Status.started;
  bool get isClosed => status == Status.ended;
  bool get isWaiting => status == Status.waiting;

  String get statusChipLabel => isOpen
      ? 'Now open'
      : isRunning
          ? 'Currently running'
          : isWaiting
              ? 'Starting soon'
              : 'Finished';

  // Crowdaction banner url
  String get bannerUrl => images.banner.imageUrl;

  // Crowdaction card url
  String get cardUrl => images.card.imageUrl;
}

@freezed
class Images with _$Images {
  const factory Images({
    required String card,
    required String banner,
  }) = _Images;
}

@freezed
class Location with _$Location {
  const factory Location({
    required String code,
    required String name,
  }) = _Location;
}

enum Status {
  @JsonValue('STARTED')
  started,
  @JsonValue('WAITING')
  waiting,
  @JsonValue('ENDED')
  ended,
}

enum JoinStatus {
  @JsonValue('OPEN')
  open,
  @JsonValue('CLOSED')
  closed,
}

@freezed
class Commitment with _$Commitment {
  const Commitment._();

  factory Commitment({
    required String id,
    required String label,
    required int points,
    required List<String> blocks,
    String? description,
    String? iconId,
  }) = _Commitment;

  IconData get icon => iconId != null
      ? IconUtil.fromString(iconId!)
      : CollactionIcons.collaction;
}
