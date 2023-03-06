import 'package:collaction_app/domain/settings/build_information.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test for BuildInformation() constructor', () {
    const tBuildInfo =
        BuildInformation(buildNumber: 'tBuildNo', version: 'tVersion');
    expect(tBuildInfo.buildNumber, 'tBuildNo');
    expect(tBuildInfo.version, 'tVersion');
    expect(tBuildInfo.environment, null);

    final BuildInformation tBuildInfoWEnv =
        tBuildInfo.copyWith(environment: () => 'tEnv');
    expect(tBuildInfoWEnv.environment, 'tEnv');
    expect(tBuildInfoWEnv.buildNumber, 'tBuildNo');
    expect(tBuildInfoWEnv.version, 'tVersion');
  });
}
