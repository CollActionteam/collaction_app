import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowdaction_comment_dto.freezed.dart';
part 'crowdaction_comment_dto.g.dart';

@freezed
class CrowdactionCommentDto with _$CrowdactionCommentDto {
  /// {@macro crowdaction_comment_dto}
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
}
