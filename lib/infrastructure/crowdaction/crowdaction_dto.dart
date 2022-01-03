// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/crowdaction/crowdaction.dart';
import '../crowdaction/crowdaction.ext.dart';

part 'crowdaction_dto.freezed.dart';

part 'crowdaction_dto.g.dart';

@freezed
class CrowdActionDto with _$CrowdActionDto {
  const CrowdActionDto._();

  factory CrowdActionDto({
    required String crowdactionID,
    required String title,
    required String description,
    required String category,
    required String location,
    required ImagesDto images,

    /// TODO: Rename DTO fields when naming conventions are up to date
    required List<TopParticipantDto> top_participants,
    required List<CommitmentOptionDto> commitment_options,
    required String date_start,
    required String date_end,
    required String date_limit_join,
    int? participant_count,
    String? password_join,
    String? subcategory,
  }) = _CrowdActionDto;

  CrowdAction toDomain() {
    return CrowdAction(
      crowdactionID: crowdactionID,
      title: title,
      description: description,
      category: category,
      location: location,
      topParticipants: top_participants
          .map((participant) => participant.toDomain())
          .toList(),
      commitmentOptions: commitment_options
          .flatten()
          .map((option) => option.toDomain())
          .toList(),
      dateStart: DateTime.parse(date_start),
      dateEnd: DateTime.parse(date_end),
      dateLimitJoin: DateTime.parse(date_limit_join),
      images: images.toDomain(),
      participantCount: participant_count ?? 0,
      passwordJoin: password_join,
      subCategory: subcategory,
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
class CommitmentOptionDto with _$CommitmentOptionDto {
  const CommitmentOptionDto._();

  factory CommitmentOptionDto({
    required String id,
    required String label,
    required String description,
    List<CommitmentOptionDto>? requires,
    String? ref,
  }) = _CommitmentOptionDto;

  CommitmentOption toDomain() {
    return CommitmentOption(
      id: id,
      label: label,
      description: description,
      ref: ref,
    );
  }

  factory CommitmentOptionDto.fromJson(Map<String, dynamic> json) =>
      _$CommitmentOptionDtoFromJson(json);
}

@freezed
class TopParticipantDto with _$TopParticipantDto {
  const TopParticipantDto._();

  factory TopParticipantDto({
    required String userID,
    required String name,
    String? imageUrl,
  }) = _TopParticipantDto;

  TopParticipant toDomain() {
    return TopParticipant(
      userId: userID,
      name: name,
      imageUrl: imageUrl,
    );
  }

  factory TopParticipantDto.fromJson(Map<String, dynamic> json) =>
      _$TopParticipantDtoFromJson(json);
}
