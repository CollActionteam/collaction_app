import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../domain/i_settings_repository.dart';

const _keyIsSignupEnabled = 'is_signup_enabled';
const _defaults = {_keyIsSignupEnabled: false};
const _refreshInterval = Duration(minutes: 5);
const _fetchTimeout = Duration(seconds: 60);
final _minimumFetchInterval = _fetchTimeout + const Duration(seconds: 1);

@Singleton(
    as: ISettingsRepository) // Instantiate immediately in order to fetch configs before needed
class SettingsRepository implements ISettingsRepository, Disposable {
  final RemoteConfig _remoteConfig;
  late final StreamSubscription _streamSubscription;

  SettingsRepository(this._remoteConfig) {
    _remoteConfig.setDefaults(_defaults);
    _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: _fetchTimeout,
        minimumFetchInterval: _minimumFetchInterval));
    _remoteConfig.fetchAndActivate();
    _streamSubscription = Stream.periodic(_refreshInterval).listen((_) {
      _remoteConfig.fetchAndActivate();
    });
  }

  @override
  FutureOr onDispose() {
    _streamSubscription.cancel();
  }

  @override
  bool get isSignupEnabled {
    return _remoteConfig.getBool(_keyIsSignupEnabled);
  }
}
