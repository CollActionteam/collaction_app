abstract class CrowdActionFailure {
  const CrowdActionFailure();

  const factory CrowdActionFailure.serverError() = ServerError;

  const factory CrowdActionFailure.networkRequestFailed() =
      NetworkRequestFailed;
}

class ServerError extends CrowdActionFailure {
  const ServerError();
}

class NetworkRequestFailed extends CrowdActionFailure {
  const NetworkRequestFailed();
}
