import 'package:collaction_app/domain/settings/build_information.dart';

abstract class ISettingsRepository {
  Future<String> get baseApiEndpointUrl;

  Future<String> get getEnv;

  /// Returns a [bool] indicating whether the user has been onboarded. (device storage)
  Future<bool> getWasUserOnboarded();

  // ignore: avoid_positional_boolean_parameters
  Future<void> setWasUserOnboarded({required bool wasOnboarded});

  //* Get list of private crowdaction IDs the user has access to.
  Future<List<String>> getCrowdActionAccessList();

  //* Add _crowdactionId_ to list of strings in shared preferences.
  Future<void> addCrowdActionAccess({required String crowdActionId});

  /// Returns [BuildInformation] populated by env and package info
  Future<BuildInformation> getBuildInformation();
}
