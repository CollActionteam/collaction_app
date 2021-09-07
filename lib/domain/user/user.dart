import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const User._();

  static Future<String?> _getAnonymousIdToken([bool forceRefresh = false]) =>
      Future.value(null);
  static const User anonymous = User(
      id: 'anonymous',
      displayName: 'anonymous',
      getIdToken: _getAnonymousIdToken);

  bool get isAnonymous => this == anonymous;

  // TODO: should the user really have any fields beyond id token?
  // ...since the profile will most likely be provided by an external microservice
  const factory User({
    required String id,
    required Future<String?> Function([bool forceRefresh]) getIdToken,
    String? displayName,
    String? photoURL,
    String? email,
    @Default(false) bool isEmailVerified,
    String? phoneNumber,
    @Default(false) bool isPhoneNumberVerified,
  }) = _User;
}
