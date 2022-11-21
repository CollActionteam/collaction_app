// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/crowdaction/crowdaction.dart';

part 'crowdaction_dto.freezed.dart';

part 'crowdaction_dto.g.dart';

@freezed
class CrowdActionDto with _$CrowdActionDto {
  const CrowdActionDto._();

  const factory CrowdActionDto({
    required String id,
    required String type,
    required String title,
    required String description,
    required String category,
    required LocationDto location,
    required List<CommitmentOptionDto> commitmentOptions,
    required ImagesDto images,
    required int participantCount,
    required Status status,
    required JoinStatus joinStatus,
    required String endAt,
    String? password,
    String? subcategory,
  }) = _CrowdActionDto;

  CrowdAction toDomain() {
    return CrowdAction(
      id: id,
      type: type,
      title: title,
      description: description,
      category: category,
      location: location.toDomain(),
      commitmentOptions:
          commitmentOptions.map((option) => option.toDomain()).toList(),
      images: images.toDomain(),
      participantCount: participantCount,
      status: status,
      joinStatus: joinStatus,
      endAt: DateTime.parse(endAt),
      password: password,
      subcategory: subcategory,
    );
  }

  factory CrowdActionDto.fromJson(Map<String, dynamic> json) =>
      _$CrowdActionDtoFromJson(json);
}

@freezed
class ImagesDto with _$ImagesDto {
  const ImagesDto._();

  factory ImagesDto({
    required String card,
    required String banner,
  }) = _ImagesDto;

  Images toDomain() {
    return Images(
      card: card,
      banner: banner,
    );
  }

  factory ImagesDto.fromJson(Map<String, dynamic> json) =>
      _$ImagesDtoFromJson(json);
}

@freezed
class LocationDto with _$LocationDto {
  const LocationDto._();

  factory LocationDto({
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

@freezed
class CommitmentOptionDto with _$CommitmentOptionDto {
  const CommitmentOptionDto._();

  factory CommitmentOptionDto({
    required String id,
    required String type,
    required String label,
    required int points,
    required List<String> blocks,
    String? description,
    String? icon,
  }) = _CommitmentOptionDto;

  CommitmentOption toDomain() {
    return CommitmentOption(
      id: id,
      type: type,
      label: label,
      points: points,
      blocks: blocks,
      description: description,
      iconId: icon,
    );
  }

  factory CommitmentOptionDto.fromJson(Map<String, dynamic> json) =>
      _$CommitmentOptionDtoFromJson(json);
}
