import 'package:freezed_annotation/freezed_annotation.dart';

part 'participation_failures.freezed.dart';

@freezed
class ParticipationFailure with _$ParticipationFailure {
  const factory ParticipationFailure.serverError() = ServerError;
  const factory ParticipationFailure.networkRequestFailed() =
      NetworkRequestFailed;
  const factory ParticipationFailure.notParticipating() = NotParticipating;
}
