import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction_comment.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction_comment_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../domain/auth/errors.dart';
import '../../domain/auth/i_auth_repository.dart';
import '../../domain/crowdaction/i_crowdaction_comments_repository.dart';
import 'crowdaction_comment_dto.dart';

@LazySingleton(as: ICrowdActionCommentsRepository)
class CrowdActionCommentsRepository implements ICrowdActionCommentsRepository {
  final http.Client _client;
  final IAuthRepository _authRepository;

  CrowdActionCommentsRepository(this._client, this._authRepository);

  @override
  Future<Either<CrowdActionCommentFailure, CrowdActionComment>> comment(
    CrowdActionComment crowdAction,
    String comment,
  ) async {
    try {
      // TODO - Request Backend team to work on end-point
      final user = (await _authRepository.getSignedInUser())
          .getOrElse(() => throw NotAuthenticatedError());

      return right(
        CrowdActionCommentDto.fromJson({
          "commentID": "32223dfs${DateTime.now().toString()}",
          "crowdactionID": "Stuff",
          "message": comment,
          "authorId": user.id,
          "createdAt": DateTime.now().toString()
        }).toDomain(),
      );
    } catch (e) {
      return left(const CrowdActionCommentFailure.networkRequestFailed());
    }
  }

  @override
  Future<Either<CrowdActionCommentFailure, CrowdActionComment>> createComment(
    CrowdAction crowdAction,
    String comment,
  ) async {
    try {
      final user = (await _authRepository.getSignedInUser())
          .getOrElse(() => throw NotAuthenticatedError());

      // TODO - Request Backend team to work on end-point
      return right(
        CrowdActionCommentDto.fromJson({
          "commentID": "xdfffgfgfg${DateTime.now().toString()}",
          "crowdactionID": "Stuff",
          "message": comment,
          "authorId": user.id,
          "createdAt": DateTime.now().toString()
        }).toDomain(),
      );
    } catch (e) {
      return left(const CrowdActionCommentFailure.networkRequestFailed());
    }
  }

  @override
  Future<Either<CrowdActionCommentFailure, Unit>> deleteComment(
    CrowdActionComment comment,
  ) async {
    try {
      // TODO - Request Backend team to work on end-point
      return right(unit);
    } catch (e) {
      return left(const CrowdActionCommentFailure.networkRequestFailed());
    }
  }

  @override
  Future<Either<CrowdActionCommentFailure, Unit>> disLikeComment(
    CrowdActionComment comment,
  ) async {
    try {
      // TODO - Request Backend team to work on end-point
      return right(unit);
    } catch (e) {
      return left(const CrowdActionCommentFailure.networkRequestFailed());
    }
  }

  @override
  Future<Either<CrowdActionCommentFailure, Unit>> flagComment(
    CrowdActionComment comment,
    String reason,
  ) async {
    try {
      // TODO - Request Backend team to work on end-point
      return right(unit);
    } catch (e) {
      return left(const CrowdActionCommentFailure.networkRequestFailed());
    }
  }

  @override
  Future<Either<CrowdActionCommentFailure, List<CrowdActionComment>>>
      getComments(CrowdActionComment comment) async {
    try {
      /// TODO - Request Backend team to work on end-point
      return right(
        [
          {
            "commentID": "xdfffgfgfg34",
            "crowdactionID": "Stuff",
            "message":
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            "authorId": "2VHwkJn1GhZAvSCxYf2OKMIJBc72",
            "createdAt": DateTime.now().toString()
          },
          {
            "commentID": "xdfffgfgfghj12",
            "crowdactionID": "Stuff",
            "message": '''
              Lorem est cupidatat dolor ullamco minim dolore aliqua ipsum eiusmod esse velit magna minim fugiat minim labore adipiscing proident. Dolore non aliqua aliquip enim ut non in laboris cillum ipsum eiusmod. Laborum nulla proident quis velit aliqua nulla ipsum mollit et incididunt dolore aliquip qui mollit proident quis commodo.

Fugiat sint amet ea eiusmod ad proident culpa quis veniam veniam incididunt pariatur. Do dolore officia cupidatat commodo quis magna eiusmod aute eiusmod nisi et officia duis non. Anim minim labore commodo ea voluptate minim elit eu adipiscing. Nostrud duis consectetur proident est dolor velit sit sint non commodo id laborum minim pariatur eu nisi proident. Duis nisi ad laboris elit esse sint cupidatat nisi sed do occaecat velit aliquip ex tempor anim.
            ''',
            "authorId": "2VHwkJn1GhZAvSCxYf2QKMIJBc72",
            "likes": 1,
            "createdAt": DateTime(2022, 3, 5).toString()
          }
        ]
            .map((json) => CrowdActionCommentDto.fromJson(json).toDomain())
            .toList(),
      );
    } catch (error) {
      return left(const CrowdActionCommentFailure.networkRequestFailed());
    }
  }

  @override
  Future<Either<CrowdActionCommentFailure, List<CrowdActionComment>>>
      getCrowdActionComments(CrowdAction crowdAction) async {
    try {
      /// TODO - Request Backend team to work on end-point
      return right(
        [
          {
            "commentID": "xdfffgfgfg",
            "crowdactionID": "Stuff",
            "message":
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            "authorId": "2VHwkJn1GhZAvSCxYf2OKMIJBc72",
            "createdAt": DateTime.now().toString()
          },
          {
            "commentID": "xdfffgfgfghj",
            "crowdactionID": "Stuff",
            "message": '''
              Lorem est cupidatat dolor ullamco minim dolore aliqua ipsum eiusmod esse velit magna minim fugiat minim labore adipiscing proident. Dolore non aliqua aliquip enim ut non in laboris cillum ipsum eiusmod. Laborum nulla proident quis velit aliqua nulla ipsum mollit et incididunt dolore aliquip qui mollit proident quis commodo.

Fugiat sint amet ea eiusmod ad proident culpa quis veniam veniam incididunt pariatur. Do dolore officia cupidatat commodo quis magna eiusmod aute eiusmod nisi et officia duis non. Anim minim labore commodo ea voluptate minim elit eu adipiscing. Nostrud duis consectetur proident est dolor velit sit sint non commodo id laborum minim pariatur eu nisi proident. Duis nisi ad laboris elit esse sint cupidatat nisi sed do occaecat velit aliquip ex tempor anim.
            ''',
            "authorId": "2VHwkJn1GhZAvSCxYf2QKMIJBc72",
            "likes": 1,
            "createdAt": DateTime(2022, 3, 5).toString()
          }
        ]
            .map((json) => CrowdActionCommentDto.fromJson(json).toDomain())
            .toList(),
      );
    } catch (error) {
      return left(const CrowdActionCommentFailure.networkRequestFailed());
    }
  }

  @override
  Future<Either<CrowdActionCommentFailure, Unit>> likeComment(
    CrowdActionComment comment,
  ) async {
    try {
      // TODO - Request Backend team to work on end-point
      return right(unit);
    } catch (e) {
      return left(const CrowdActionCommentFailure.networkRequestFailed());
    }
  }
}
