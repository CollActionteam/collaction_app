part of '../crowdaction_dto.dart';

class LocationDto extends Equatable {
  const LocationDto({
    required this.code,
    required this.name,
  });

  Location toDomain() {
    return Location(
      code: code,
      name: name,
    );
  }

  factory LocationDto.fromJson(Map<String, dynamic> json) => LocationDto(
        code: json['code'] as String,
        name: json['name'] as String,
      );

  final String code;

  final String name;

  LocationDto copyWith({
    String? code,
    String? name,
  }) {
    return LocationDto(
      code: code ?? this.code,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [
        code,
        name,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'name': name,
      };
}
