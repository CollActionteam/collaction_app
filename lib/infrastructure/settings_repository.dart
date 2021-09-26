import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/i_settings_repository.dart';

const _releaseBaseApiEndpoint = 'http://api.collaction.org';
const _prefsKeyBaseApiEndpoint = 'base_api_endpoint';
const _prefsKeyWasUserOnboarded = 'was_user_onboarded';

@LazySingleton(as: ISettingsRepository)
class SettingsRepository implements ISettingsRepository, Disposable {
  final SharedPreferences prefs;
  late final StreamSubscription _streamSubscription;

  SettingsRepository({required this.prefs});

  @override
  FutureOr onDispose() => _streamSubscription.cancel();

  @override
  String get baseApiEndpoint => kReleaseMode
      ? _releaseBaseApiEndpoint
      : (prefs.getString(_prefsKeyBaseApiEndpoint) ?? _releaseBaseApiEndpoint);

  @override
  set baseApiEndpoint(String value) {
    if (kReleaseMode) {
      throw Exception('Cannot change value in release mode!');
    }
    prefs.setString(_prefsKeyBaseApiEndpoint, value);
  }

  @override
  bool get wasUserOnboarded =>
      prefs.getBool(_prefsKeyWasUserOnboarded) ?? false;

  @override
  set wasUserOnboarded(bool value) {
    prefs.setBool(_prefsKeyWasUserOnboarded, value);
  }
}
