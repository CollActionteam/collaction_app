import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowdaction_status.freezed.dart';

@freezed
class CrowdActionStatus with _$CrowdActionStatus {
  const factory CrowdActionStatus.subscribed(List<String> commitments) =
      SubscribedToCrowdAction;

  const factory CrowdActionStatus.notSubscribed() = NotSubscribedToCrowdAction;
}
