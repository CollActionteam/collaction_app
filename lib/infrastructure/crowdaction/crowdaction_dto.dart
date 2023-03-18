// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/crowdaction/crowdaction.dart';
import '../badge/badge_dto.dart';

part 'crowdaction_dto.freezed.dart';

part 'crowdaction_dto.g.dart';

@freezed
class CrowdActionDto with _$CrowdActionDto {
  const CrowdActionDto._();

  const factory CrowdActionDto({
    required String id,
    required String title,
    required String description,
    required String category,
    required LocationDto location,
    required List<CommitmentDto> commitments,
    required ImagesDto images,
    required int participantCount,
    required Status status,
    required JoinStatus joinStatus,
    required String endAt,
    String? password,
    String? subcategory,
    List<BadgeDto>? badges,
  }) = _CrowdActionDto;

  CrowdAction toDomain() {
    return CrowdAction(
      id: id,
      title: title,
      description: description,
      category: category,
      location: location.toDomain(),
      commitments: commitments.map((c) => c.toDomain()).toList(),
      images: images.toDomain(),
      participantCount: participantCount,
      status: status,
      joinStatus: joinStatus,
      endAt: DateTime.parse(endAt),
      password: password,
      subcategory: subcategory,
      badges: badges?.map((option) => option.toDomain()).toList(),
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
class CommitmentDto with _$CommitmentDto {
  const CommitmentDto._();

  factory CommitmentDto({
    // ignore: invalid_annotation_target
    @JsonKey(name: '_id') required String id,
    required String label,
    required int points,
    required List<String> blocks,
    String? description,
    String? icon,
  }) = _CommitmentDto;

  Commitment toDomain() {
    return Commitment(
      id: id,
      label: label,
      points: points,
      blocks: blocks,
      description: description,
      iconId: icon,
    );
  }

  factory CommitmentDto.fromJson(Map<String, dynamic> json) =>
      _$CommitmentDtoFromJson(json);
}
