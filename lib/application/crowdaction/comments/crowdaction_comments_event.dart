part of 'crowdaction_comments_bloc.dart';

@freezed
class CrowdactionCommentsEvent with _$CrowdactionCommentsEvent {
  /// Read root comments for a particular CrowdAction
  const factory CrowdactionCommentsEvent.loadComments(CrowdAction crowdAction) =
      _LoadCrowdActionComments;

  /// Read comments for a particular CrowdAction comment
  const factory CrowdactionCommentsEvent.loadCommentComments(
    CrowdActionComment comment,
  ) = _LoadCommentComments;

  /// Like a comment
  const factory CrowdactionCommentsEvent.likeComment(
    CrowdActionComment comment,
  ) = _LikeComment;

  /// Dislike a comment
  const factory CrowdactionCommentsEvent.disLikeComment(
    CrowdActionComment comment,
  ) = _DisikeComment;

  /// Flag a comment
  const factory CrowdactionCommentsEvent.flagComment(
    CrowdActionComment comment,
    String reason,
  ) = _FlagComment;

  /// Delete a comment
  const factory CrowdactionCommentsEvent.deleteComment(
    CrowdActionComment comment,
  ) = _DeleteComment;

  /// Send a comment
  const factory CrowdactionCommentsEvent.comment(
    CrowdAction crowdAction,
    String message,
  ) = _SendComment;

  /// Comment on a comment
  const factory CrowdactionCommentsEvent.commentOnAComment(
    CrowdActionComment comment,
    String message,
  ) = _CommentOnAComment;
}
