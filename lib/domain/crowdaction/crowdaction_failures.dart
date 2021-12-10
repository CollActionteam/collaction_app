import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowdaction_failures.freezed.dart';

@freezed
class CrowdActionFailure with _$CrowdActionFailure {
  const factory CrowdActionFailure.serverError() = ServerError;

  const factory CrowdActionFailure.networkRequestFailed() =
      NetworkRequestFailed;
}
