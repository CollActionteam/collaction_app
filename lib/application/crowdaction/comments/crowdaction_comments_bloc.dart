import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../../domain/crowdaction/crowdaction_comment.dart';
import '../../../domain/crowdaction/crowdaction_comment_failures.dart';
import '../../../domain/crowdaction/i_crowdaction_comments_repository.dart';

part 'crowdaction_comments_bloc.freezed.dart';

part 'crowdaction_comments_event.dart';

part 'crowdaction_comments_state.dart';

@injectable
class CrowdactionCommentsBloc
    extends Bloc<CrowdactionCommentsEvent, CrowdactionCommentsState> {
  final ICrowdActionCommentsRepository _commentsRepository;

  CrowdactionCommentsBloc(this._commentsRepository)
      : super(const CrowdactionCommentsState.initial()) {
    on<CrowdactionCommentsEvent>((event, emit) async {
      await event.map(
        loadComments: (value) async => _loadComments(emit, value),
        loadCommentComments: (value) async => _loadCommentComments(emit, value),
        likeComment: (value) async => _likeComment(emit, value),
        disLikeComment: (value) async => _dislikeComment(emit, value),
        flagComment: (value) async => _flagComment(emit, value),
        deleteComment: (value) async => _deleteComment(emit, value),
        comment: (value) async => _comment(emit, value),
        commentOnAComment: (value) async => _commentOnComment(emit, value),
      );
    });
  }

  Future<void> _loadComments(
    Emitter<CrowdactionCommentsState> emit,
    _LoadCrowdActionComments value,
  ) async {
    emit(const CrowdactionCommentsState.loadingCrowdActionComments());

    final resultOrFailure =
        await _commentsRepository.getCrowdActionComments(value.crowdAction);

    emit(
      resultOrFailure.fold(
        (failure) =>
            CrowdactionCommentsState.errorLoadingCrowdActionComments(failure),
        (comments) =>
            CrowdactionCommentsState.loadedCrowdActionComments(comments),
      ),
    );
  }

  Future<void> _loadCommentComments(
    Emitter<CrowdactionCommentsState> emit,
    _LoadCommentComments value,
  ) async {
    emit(CrowdactionCommentsState.loadingComments(value.comment));

    final resultOrFailure =
        await _commentsRepository.getComments(value.comment);

    emit(
      resultOrFailure.fold(
        (failure) => CrowdactionCommentsState.errorLoadingComments(
          value.comment,
          failure,
        ),
        (comments) => CrowdactionCommentsState.loadedComments(
          value.comment,
          comments,
        ),
      ),
    );
  }

  Future<void> _likeComment(
    Emitter<CrowdactionCommentsState> emit,
    _LikeComment value,
  ) async {
    emit(CrowdactionCommentsState.likingComment(value.comment));

    final resultOrFailure =
        await _commentsRepository.likeComment(value.comment);

    emit(
      resultOrFailure.fold(
        (failure) => CrowdactionCommentsState.errorLikingComment(
          value.comment,
          failure,
        ),
        (comments) => CrowdactionCommentsState.likedComment(
          value.comment,
        ),
      ),
    );
  }

  Future<void> _dislikeComment(
    Emitter<CrowdactionCommentsState> emit,
    _DisikeComment value,
  ) async {
    emit(CrowdactionCommentsState.dislikingComment(value.comment));

    final resultOrFailure =
        await _commentsRepository.disLikeComment(value.comment);

    emit(
      resultOrFailure.fold(
        (failure) => CrowdactionCommentsState.errorDislikingComment(
          value.comment,
          failure,
        ),
        (comments) => CrowdactionCommentsState.dislikedComment(
          value.comment,
        ),
      ),
    );
  }

  Future<void> _flagComment(
    Emitter<CrowdactionCommentsState> emit,
    _FlagComment value,
  ) async {
    emit(CrowdactionCommentsState.flaggingComment(value.comment));

    final resultOrFailure =
        await _commentsRepository.flagComment(value.comment, value.reason);

    emit(
      resultOrFailure.fold(
        (failure) => CrowdactionCommentsState.errorFlaggingComment(
          value.comment,
          failure,
        ),
        (comments) => CrowdactionCommentsState.flaggedComment(
          value.comment,
        ),
      ),
    );
  }

  Future<void> _deleteComment(
    Emitter<CrowdactionCommentsState> emit,
    _DeleteComment value,
  ) async {
    emit(CrowdactionCommentsState.deletingComment(value.comment));

    final resultOrFailure =
        await _commentsRepository.deleteComment(value.comment);

    emit(
      resultOrFailure.fold(
        (failure) => CrowdactionCommentsState.errorDeletingComment(
          value.comment,
          failure,
        ),
        (comments) => CrowdactionCommentsState.deletedComment(
          value.comment,
        ),
      ),
    );
  }

  Future<void> _comment(
    Emitter<CrowdactionCommentsState> emit,
    _SendComment value,
  ) async {
    emit(CrowdactionCommentsState.creatingComment(value.crowdAction));

    final resultOrFailure = await _commentsRepository.createComment(
      value.crowdAction,
      value.message,
    );

    emit(
      resultOrFailure.fold(
        (failure) => CrowdactionCommentsState.errorCreatingComment(
          failure,
        ),
        (comment) => CrowdactionCommentsState.createdComment(comment),
      ),
    );
  }

  Future<void> _commentOnComment(
    Emitter<CrowdactionCommentsState> emit,
    _CommentOnAComment value,
  ) async {
    emit(CrowdactionCommentsState.commenting(value.comment));

    final resultOrFailure =
        await _commentsRepository.comment(value.comment, value.message);

    emit(
      resultOrFailure.fold(
        (failure) => CrowdactionCommentsState.errorCommenting(
          value.comment,
          failure,
        ),
        (comment) => CrowdactionCommentsState.commented(
          value.comment,
          comment,
        ),
      ),
    );
  }
}
