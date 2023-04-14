import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const User._();

  @visibleForTesting
  // ignore: avoid_positional_boolean_parameters
  static Future<String?> getAnonymousIdToken([bool forceRefresh = false]) =>
      Future.value();

  static const User anonymous = User(
    id: 'anonymous',
    getIdToken: getAnonymousIdToken,
  );

  bool get isAnonymous => this == anonymous;

  /// TODO: Refactor after MVP to only neccessary fields (use profile microservice for details)
  const factory User({
    required String id,
    required Future<String?> Function([bool forceRefresh]) getIdToken,
    DateTime? joinDate,
    String? email,
    String? phoneNumber,
    @Default(false) bool isEmailVerified,
    @Default(false) bool isPhoneNumberVerified,
  }) = _User;

  String get formattedJoinDate {
    return DateFormat('MMMM yyyy').format(joinDate!);
  }
}
