import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/i_settings_repository.dart';

const _keyIsSignupEnabled = 'is_signup_enabled';
const _defaults = {_keyIsSignupEnabled: false};
const _refreshInterval = Duration(minutes: 5);
const _fetchTimeout = Duration(seconds: 60);
final _minimumFetchInterval = _fetchTimeout + const Duration(seconds: 1);
const _releaseBaseApiEndpoint = 'http://api.collaction.org';
const _prefsKeyBaseApiEndpoint = 'base_api_endpoint';
const _prefsKeyWasUserOnboarded = 'was_user_onboarded';

@LazySingleton(as: ISettingsRepository)
class SettingsRepository implements ISettingsRepository, Disposable {
  final RemoteConfig remoteConfig;
  final SharedPreferences prefs;
  late final StreamSubscription _streamSubscription;

  SettingsRepository({required this.remoteConfig, required this.prefs}) {
    remoteConfig.setDefaults(_defaults);
    remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: _fetchTimeout,
        minimumFetchInterval: _minimumFetchInterval));
    remoteConfig.fetchAndActivate();
    _streamSubscription = Stream.periodic(_refreshInterval).listen((_) {
      remoteConfig.fetchAndActivate();
    });
  }

  @override
  FutureOr onDispose() => _streamSubscription.cancel();

  @override
  bool get isSignupEnabled => remoteConfig.getBool(_keyIsSignupEnabled);

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
