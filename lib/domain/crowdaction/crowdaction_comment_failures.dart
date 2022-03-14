import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowdaction_comment_failures.freezed.dart';
@freezed
class CrowdActionCommentFailure with _$CrowdActionCommentFailure {
  const factory CrowdActionCommentFailure.serverError() = ServerError;

  const factory CrowdActionCommentFailure.networkRequestFailed() =
      NetworkRequestFailed;
}
