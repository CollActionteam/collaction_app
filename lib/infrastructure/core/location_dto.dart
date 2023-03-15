import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/core/location.dart';

part 'location_dto.freezed.dart';
part 'location_dto.g.dart';

@freezed
class LocationDto with _$LocationDto {
  const LocationDto._();

  const factory LocationDto({
    required String code,
    required String name,
  }) = _LocationDto;

  Location toDomain() {
    return Location(
      code: code,
      name: name,
    );
  }

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);
}
