import 'package:freezed_annotation/freezed_annotation.dart';

part 'build_information.freezed.dart';

@freezed
class BuildInformation with _$BuildInformation {
  const BuildInformation._();

  const factory BuildInformation({
    required String buildNumber,
    required String version,
    String? environment,
  }) = _BuildInformation;
}
