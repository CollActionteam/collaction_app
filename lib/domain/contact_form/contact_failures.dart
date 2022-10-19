import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_failures.freezed.dart';

@freezed
class ContactFailure with _$ContactFailure {
  const factory ContactFailure.serverError() = ServerError;
  const factory ContactFailure.unexpectedError() = UnexpectedError;
}
