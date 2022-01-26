import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/crowdaction/crowdaction_comment.dart';

part 'crowdaction_comment_dto.freezed.dart';
part 'crowdaction_comment_dto.g.dart';

@freezed
class CrowdActionCommentDto with _$CrowdActionCommentDto {
  const CrowdActionCommentDto._();

  factory CrowdActionCommentDto({
    required String crowdactionID,
    required String message,
    required String authorId,
    required String createdAt,
  }) = _CrowdActionCommentDto;

  CrowdActionComment toDomain() {
    return CrowdActionComment(
      crowdactionID: crowdactionID,
      message: message,
      authorId: authorId,
      createdAt: DateTime.tryParse(createdAt)!,
    );
  }

  factory CrowdActionCommentDto.fromJson(Map<String, dynamic> json) =>
      _$CrowdActionCommentDtoFromJson(json);
}
