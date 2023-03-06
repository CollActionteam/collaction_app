abstract class AuthFailure {
  const AuthFailure();

  const factory AuthFailure.serverError() = ServerError;

  const factory AuthFailure.networkRequestFailed() = NetworkRequestFailed;

  const factory AuthFailure.invalidPhone() = InvalidPhone;

  const factory AuthFailure.invalidSmsCode() = InvalidSmsCode;

  const factory AuthFailure.verificationFailed() = VerificationFailed;
}

class ServerError extends AuthFailure {
  const ServerError();
}

class NetworkRequestFailed extends AuthFailure {
  const NetworkRequestFailed();
}

class InvalidPhone extends AuthFailure {
  const InvalidPhone();
}

class InvalidSmsCode extends AuthFailure {
  const InvalidSmsCode();
}

class VerificationFailed extends AuthFailure {
  const VerificationFailed();
}
