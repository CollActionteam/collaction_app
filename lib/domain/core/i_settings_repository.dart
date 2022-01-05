abstract class ISettingsRepository {
  Future<String> get baseApiEndpointUrl;

  Future<bool> getWasUserOnboarded();

  // ignore: avoid_positional_boolean_parameters
  Future<void> setWasUserOnboarded({required bool wasOnboarded});

  //* Get list of private crowdaction IDs the user has access to.
  Future<List<String>> getCrowdActionAccessList();

  //* Add _crowdactionId_ to list of strings in shared preferences.
  Future<void> addCrowdActionAccess({required String crowdActionId});
}
