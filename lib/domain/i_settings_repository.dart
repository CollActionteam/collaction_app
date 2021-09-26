abstract class ISettingsRepository {
  String get baseApiEndpoint;
  set baseApiEndpoint(String value);
  bool get wasUserOnboarded;
  set wasUserOnboarded(bool value);
}
