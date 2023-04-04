import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/crowdaction/crowdaction_comment.dart';

part 'crowdaction_comment_dto.freezed.dart';
part 'crowdaction_comment_dto.g.dart';

// ignore_for_file: invalid_annotation_target
@freezed
class CrowdactionCommentDto with _$CrowdactionCommentDto {
  const CrowdactionCommentDto._();

  const factory CrowdactionCommentDto({
    @JsonKey(name: 'crowdaction_id') required String crowdactionId,
    required String content,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    List<String>? comments,
    required int likes,
    @JsonKey(name: 'liked_by_me', defaultValue: false) required bool likedByMe,
    bool? flagged,
    List<String>? flags,
  }) = _CrowdactionCommentDto;

  factory CrowdactionCommentDto.fromJson(Map<String, dynamic> data) =>
      _$CrowdactionCommentDtoFromJson(data);

  CrowdactionComment toDomain() {
    return CrowdactionComment(
      crowdactionId: crowdactionId,
      content: content,
      userId: userId,
      createdAt: createdAt,
      likes: likes,
      likedByMe: likedByMe,
    );
  }
}
