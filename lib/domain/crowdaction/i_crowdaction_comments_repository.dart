import 'package:dartz/dartz.dart';

import 'crowdaction.dart';
import 'crowdaction_comment.dart';
import 'crowdaction_comment_failures.dart';

abstract class ICrowdActionCommentsRepository {
  Future<Either<CrowdActionCommentFailure, List<CrowdActionComment>>>
      getCrowdActionComments(
    CrowdAction crowdAction,
  );

  Future<Either<CrowdActionCommentFailure, List<CrowdActionComment>>>
      getComments(
    CrowdActionComment comment,
  );

  Future<Either<CrowdActionCommentFailure, Unit>> likeComment(
    CrowdActionComment comment,
  );

  Future<Either<CrowdActionCommentFailure, Unit>> disLikeComment(
    CrowdActionComment comment,
  );

  Future<Either<CrowdActionCommentFailure, Unit>> flagComment(
    CrowdActionComment comment,
    String reason,
  );

  Future<Either<CrowdActionCommentFailure, Unit>> deleteComment(
    CrowdActionComment comment,
  );

  Future<Either<CrowdActionCommentFailure, CrowdActionComment>> createComment(
    CrowdAction crowdAction,
    String comment,
  );

  Future<Either<CrowdActionCommentFailure, CrowdActionComment>> comment(
    CrowdActionComment crowdAction,
    String comment,
  );
}
