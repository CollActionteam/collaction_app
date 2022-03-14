import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowdaction_comment.freezed.dart';

@freezed
class CrowdActionComment with _$CrowdActionComment {
  const CrowdActionComment._();

  const factory CrowdActionComment({
    required String commentID,
    required String crowdactionID,
    required String message,
    required String authorId,
    int? likes,
    required DateTime createdAt,
  }) = _CrowdActionComment;
}

extension CrowdActionCommentX on CrowdActionComment {
  bool get hasLikes => likesCount > 0;

  int get likesCount => likes ?? 0;

  String get likesText => "$likesCount like${likesCount > 1 ? 's' : ''}";
}
