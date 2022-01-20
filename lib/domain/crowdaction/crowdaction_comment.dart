import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowdaction_comment.freezed.dart';

@freezed
class CrowdActionComment with _$CrowdActionComment {
  const CrowdActionComment._();

  const factory CrowdActionComment({
    required String crowdactionID,
    required String message,
    required String senderId,
    required DateTime createdAt,
  }) = _CrowdActionComment;
}
