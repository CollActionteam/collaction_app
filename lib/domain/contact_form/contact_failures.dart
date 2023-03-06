import 'package:equatable/equatable.dart';

abstract class ContactFailure extends Equatable {
  const ContactFailure();

  const factory ContactFailure.serverError() = ServerError;
  const factory ContactFailure.unexpectedError() = UnexpectedError;

  @override
  List<Object?> get props => [];
}

class ServerError extends ContactFailure {
  const ServerError();
}

class UnexpectedError extends ContactFailure {
  const UnexpectedError();
}
