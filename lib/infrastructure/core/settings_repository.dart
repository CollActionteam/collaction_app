import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/core/i_settings_repository.dart';

const _envKeyBaseApiEndpointUrl = 'BASE_API_ENDPOINT_URL';
const _prefsKeyWasUserOnboarded = 'was_user_onboarded';
const _prefsKeyCrowdActionAccessList = 'crowdaction_access_list';

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
  Future<void> setWasUserOnboarded({required bool wasOnboarded}) async {
    await _initCompleter.future;
    _prefs.setBool(_prefsKeyWasUserOnboarded, wasOnboarded);
  }

  @override
  Future<List<String>> getCrowdActionAccessList() async {
    await _initCompleter.future;
    return _prefs.getStringList(_prefsKeyCrowdActionAccessList) ?? [];
  }

  @override
  Future<void> addCrowdActionAccess({required String crowdActionId}) async {
    await _initCompleter.future;
    final _crowdActionAccessList =
        _prefs.getStringList(_prefsKeyCrowdActionAccessList) ?? [];
    _crowdActionAccessList.add(crowdActionId);
    _prefs.setStringList(
      _prefsKeyCrowdActionAccessList,
      _crowdActionAccessList,
    );
  }
}
