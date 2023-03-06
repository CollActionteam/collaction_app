import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class User extends Equatable {
  final String id;
  final Future<String?> Function([bool forceRefresh]) getIdToken;
  final DateTime? joinDate;
  final String? email;
  final String? phoneNumber;
  final bool isEmailVerified;
  final bool isPhoneNumberVerified;

  const User({
    required this.id,
    required this.getIdToken,
    this.joinDate,
    this.email,
    this.phoneNumber,
    this.isEmailVerified = false,
    this.isPhoneNumberVerified = false,
  });

  @visibleForTesting
  // ignore: avoid_positional_boolean_parameters
  static Future<String?> getAnonymousIdToken([bool forceRefresh = false]) =>
      Future.value();

  static const User anonymous = User(
    id: 'anonymous',
    getIdToken: getAnonymousIdToken,
  );

  bool get isAnonymous => this == anonymous;

  String get formattedJoinDate {
    return DateFormat('MMMM yyyy').format(joinDate!);
  }

  @override
  List<Object?> get props => [
        id,
        getIdToken,
        joinDate,
        email,
        phoneNumber,
        isEmailVerified,
        isPhoneNumberVerified,
      ];
}
