import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failures.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  const factory AuthFailure.serverError() = ServerError;
  const factory AuthFailure.networkRequestFailed() = NetworkRequestFailed;
  const factory AuthFailure.invalidPhone() = InvalidPhone;

  const factory AuthFailure.invalidSmsCode() = InvalidSmsCode;

  const factory AuthFailure.verificationFailed() = VerificationFailed;
}