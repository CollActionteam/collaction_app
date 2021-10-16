import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/i_settings_repository.dart';

const _envKeyBaseApiEndpointUrl = 'BASE_API_ENDPOINT_URL';
const _prefsKeyWasUserOnboarded = 'was_user_onboarded';

@LazySingleton(as: ISettingsRepository)
class SettingsRepository implements ISettingsRepository, Disposable {
  late final SharedPreferences _prefs;
  late final StreamSubscription _streamSubscription;
  final _initCompleter = Completer<void>();

  SettingsRepository() {
    Future.wait([
      dotenv.load(),
      SharedPreferences.getInstance().then((value) => _prefs = value),
    ]).then(_initCompleter.complete);
  }

  @override
  FutureOr onDispose() => _streamSubscription.cancel();

  @override
  Future<String> get baseApiEndpointUrl async {
    await _initCompleter.future;
    return dotenv.env[_envKeyBaseApiEndpointUrl]!;
  }

  @override
  Future<bool> getWasUserOnboarded() async {
    await _initCompleter.future;
    return _prefs.getBool(_prefsKeyWasUserOnboarded) ?? false;
  }

  @override
  Future<void> setWasUserOnboarded(bool value) async {
    await _initCompleter.future;
    _prefs.setBool(_prefsKeyWasUserOnboarded, value);
  }
}
