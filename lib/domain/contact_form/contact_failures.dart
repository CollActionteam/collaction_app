abstract class ContactFailure {
  const ContactFailure();

  const factory ContactFailure.serverError() = ServerError;
  const factory ContactFailure.unexpectedError() = UnexpectedError;
}

class ServerError extends ContactFailure {
  const ServerError();
}

class UnexpectedError extends ContactFailure {
  const UnexpectedError();
}
