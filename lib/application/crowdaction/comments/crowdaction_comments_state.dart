part of 'crowdaction_comments_bloc.dart';

@freezed
class CrowdactionCommentsState with _$CrowdactionCommentsState {
  /// Initial State
  const factory CrowdactionCommentsState.initial() = _Initial;

  /// Reading [CrowdAction] comments
  const factory CrowdactionCommentsState.loadingCrowdActionComments() =
      _LoadingCrowdActionComments;

  const factory CrowdactionCommentsState.loadedCrowdActionComments(
    List<CrowdActionComment> comments,
  ) = _LoadedCrowdActionComments;

  const factory CrowdactionCommentsState.errorLoadingCrowdActionComments(
    CrowdActionCommentFailure failure,
  ) = _ErrorLoadingCrowdActionComments;

  /// Reading [CrowdActionComment] comments
  const factory CrowdactionCommentsState.loadingComments(
    CrowdActionComment comment,
  ) = _LoadingComments;

  const factory CrowdactionCommentsState.loadedComments(
    CrowdActionComment comment,
    List<CrowdActionComment> comments,
  ) = _LoadedComments;

  const factory CrowdactionCommentsState.errorLoadingComments(
    CrowdActionComment comment,
    CrowdActionCommentFailure failure,
  ) = _ErrorLoadingComments;

  /// Like [CrowdActionComment]
  const factory CrowdactionCommentsState.likingComment(
    CrowdActionComment comment,
  ) = _LikingComments;

  const factory CrowdactionCommentsState.likedComment(
    CrowdActionComment comment,
  ) = _LikedComment;

  const factory CrowdactionCommentsState.errorLikingComment(
    CrowdActionComment comment,
    CrowdActionCommentFailure failure,
  ) = _ErrorLikingComments;

  /// Dislike [CrowdActionComment]
  const factory CrowdactionCommentsState.dislikingComment(
    CrowdActionComment comment,
  ) = _DislikingComments;

  const factory CrowdactionCommentsState.dislikedComment(
    CrowdActionComment comment,
  ) = _DislikedComment;

  const factory CrowdactionCommentsState.errorDislikingComment(
    CrowdActionComment comment,
    CrowdActionCommentFailure failure,
  ) = _ErrorDislikingComments;

  /// Flag [CrowdActionComment]
  const factory CrowdactionCommentsState.flaggingComment(
    CrowdActionComment comment,
  ) = _FlaggingComments;

  const factory CrowdactionCommentsState.flaggedComment(
    CrowdActionComment comment,
  ) = _FlaggedComment;

  const factory CrowdactionCommentsState.errorFlaggingComment(
    CrowdActionComment comment,
    CrowdActionCommentFailure failure,
  ) = _ErrorFlaggingComments;

  /// Delete [CrowdActionComment]
  const factory CrowdactionCommentsState.deletingComment(
    CrowdActionComment comment,
  ) = _DeletingComments;

  const factory CrowdactionCommentsState.deletedComment(
    CrowdActionComment comment,
  ) = _DeletedComment;

  const factory CrowdactionCommentsState.errorDeletingComment(
    CrowdActionComment comment,
    CrowdActionCommentFailure failure,
  ) = _ErrorDeletingComments;

  /// Create [CrowdAction] Comment
  const factory CrowdactionCommentsState.creatingComment(
    CrowdAction crowdAction,
  ) = _CreatingComment;

  const factory CrowdactionCommentsState.createdComment(
    CrowdActionComment comment,
  ) = _CreatedComment;

  const factory CrowdactionCommentsState.errorCreatingComment(
    CrowdActionCommentFailure failure,
  ) = _ErrorCreatingComment;

  /// Create [CrowdActionComment] Comment
  const factory CrowdactionCommentsState.commenting(
    CrowdActionComment comment,
  ) = _Commenting;

  const factory CrowdactionCommentsState.commented(
    CrowdActionComment comment,
    CrowdActionComment createdComment,
  ) = _Commented;

  const factory CrowdactionCommentsState.errorCommenting(
    CrowdActionComment comment,
    CrowdActionCommentFailure failure,
  ) = _ErrorCommenting;
}
