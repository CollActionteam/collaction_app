import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowdaction_comment.freezed.dart';

@freezed
class CrowdactionComment with _$CrowdactionComment {
  const CrowdactionComment._();

  const factory CrowdactionComment({
    required String crowdactionId,
    required String content,
    required String userId,
    required DateTime createdAt,
    List<String>? comments,
    required int likes,
    required bool likedByMe,
    bool? flagged,
    List<String>? flags,
  }) = _CrowdactionComment;
}
