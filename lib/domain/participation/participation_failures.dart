abstract class ParticipationFailure {
  const ParticipationFailure();

  const factory ParticipationFailure.serverError() = ServerError;
  const factory ParticipationFailure.networkRequestFailed() =
      NetworkRequestFailed;
  const factory ParticipationFailure.notParticipating() = NotParticipating;
}

class ServerError extends ParticipationFailure {
  const ServerError();
}

class NetworkRequestFailed extends ParticipationFailure {
  const NetworkRequestFailed();
}

class NotParticipating extends ParticipationFailure {
  const NotParticipating();
}
