import 'package:equatable/equatable.dart';

class BuildInformation extends Equatable {
  const BuildInformation({
    required this.buildNumber,
    required this.version,
    this.environment,
  });

  factory BuildInformation.fromJson(Map<String, dynamic> json) =>
      BuildInformation(
        buildNumber: json['buildNumber'] as String,
        version: json['version'] as String,
        environment: json['environment'] as String?,
      );

  final String buildNumber;

  final String version;

  final String? environment;

  BuildInformation copyWith({
    String? buildNumber,
    String? version,
    String? Function()? environment,
  }) {
    return BuildInformation(
      buildNumber: buildNumber ?? this.buildNumber,
      version: version ?? this.version,
      environment: environment != null ? environment() : this.environment,
    );
  }

  @override
  List<Object?> get props => [
        buildNumber,
        version,
        environment,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'buildNumber': buildNumber,
        'version': version,
        'environment': environment,
      };
}
