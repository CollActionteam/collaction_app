import 'package:collaction_app/infrastructure/settings_repository.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockFirebaseRemoteConfig extends Mock implements RemoteConfig {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('Settings Repository', () {
    registerFallbackValue(RemoteConfigSettings(
        fetchTimeout: Duration.zero, minimumFetchInterval: Duration.zero));

    RemoteConfig createMockRemoteConfig() {
      final mockRemoteConfig = MockFirebaseRemoteConfig();
      when(() => mockRemoteConfig.setDefaults(any()))
          .thenAnswer((_) => Future.value(null));
      when(() => mockRemoteConfig.fetchAndActivate())
          .thenAnswer((_) async => true);
      when(() => mockRemoteConfig.setConfigSettings(any()))
          .thenAnswer((_) => Future.value(null));
      return mockRemoteConfig;
    }

    test('Remote config defaults', () {
      final mockRemoteConfig = createMockRemoteConfig();
      SettingsRepository(
          remoteConfig: mockRemoteConfig, prefs: MockSharedPreferences());
      const defaults = {'is_signup_enabled': false};
      verify(() => mockRemoteConfig.setDefaults(defaults)).called(1);
    });

    test('Is signup enabled', () {
      final mockRemoteConfig = createMockRemoteConfig();
      final settingsRepository = SettingsRepository(
          remoteConfig: mockRemoteConfig, prefs: MockSharedPreferences());
      const key = 'is_signup_enabled';
      when(() => mockRemoteConfig.getBool(key)).thenReturn(true);
      assert(settingsRepository.isSignupEnabled == true);
      when(() => mockRemoteConfig.getBool(key)).thenReturn(false);
      assert(settingsRepository.isSignupEnabled == false);
    });
  });
}
