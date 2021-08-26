
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  static Future<String?> _getAnonymousIdToken([bool forceRefresh = false]) => Future.value(null);
  static const User anonymous = User(id: 'anonymous', displayName: 'anonymous', getIdToken: _getAnonymousIdToken);

  bool isAnonymous() => this == anonymous;

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