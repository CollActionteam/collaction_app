abstract class ISettingsRepository {
  Future<String> get baseApiEndpointUrl;
  Future<bool> getWasUserOnboarded();
  // ignore: avoid_positional_boolean_parameters
  Future<void> setWasUserOnboarded(bool value);
}
