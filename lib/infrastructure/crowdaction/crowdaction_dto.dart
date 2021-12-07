import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/crowdaction/crowdaction.dart';

part 'crowdaction_dto.freezed.dart';

part 'crowdaction_dto.g.dart';

@freezed
class CrowdActionDto with _$CrowdActionDto {
  const CrowdActionDto._();

  factory CrowdActionDto({
    @JsonKey(name: 'crowdactionID') required String crowdactionId,
    required String title,
    required String description,
    required String category,
    String? subCategory,
    required String location,
    @JsonKey(name: 'date_start') required String dateStart,
    @JsonKey(name: 'date_end') required String dateEnd,
    @JsonKey(name: 'date_limit_join') required String dateLimitJoin,
    @JsonKey(name: 'password_join') String? passwordJoin,
    @JsonKey(name: 'commitment_options')
        required List<CommitmentOption> commitmentOptions,
    @JsonKey(name: 'top_participants')
        required List<TopParticipant> topParticipants,
    int? totalParticipants,
    @JsonKey(name: 'images') required CrowdActionImages images,
  }) = _CrowdActionDto;

  CrowdAction toDomain() {
    return CrowdAction(
        crowdActionId: crowdactionId,
        title: title,
        description: description,
        category: category,
        subCategory: subCategory,
        location: location,
        start: DateTime.parse(dateStart),
        end: DateTime.parse(dateEnd),
        dateLimitJoin: DateTime.parse(dateLimitJoin),
        passwordJoin: passwordJoin,
        commitmentOptions: commitmentOptions,
        topParticipants: topParticipants,
        totalParticipants: totalParticipants ?? 0,
        images: images);
  }

  factory CrowdActionDto.fromJson(Map<String, dynamic> json) =>
      _$CrowdActionDtoFromJson(json);
}

@freezed
class CrowdActionList with _$CrowdActionList {
  const CrowdActionList._();

  factory CrowdActionList({
    required List<CrowdActionDto> crowdactions,
  }) = _CrowdActionList;

  factory CrowdActionList.fromJson(Map<String, dynamic> json) =>
      _$CrowdActionListFromJson(json);
}

@freezed
class CrowdActionImages with _$CrowdActionImages {
  factory CrowdActionImages({String? url}) = _CrowdActionImages;

  factory CrowdActionImages.fromJson(Map<String, dynamic> json) =>
      _$CrowdActionImagesFromJson(json);
}

@freezed
class TopParticipant with _$TopParticipant {
  factory TopParticipant(
      {required String name,
      String? imageUrl,
      @JsonKey(name: 'userID') required String userId}) = _TopParticipant;

  factory TopParticipant.fromJson(Map<String, dynamic> json) =>
      _$TopParticipantFromJson(json);
}

@freezed
class CommitmentOption with _$CommitmentOption {
  factory CommitmentOption(
      {required String id,
      required String label,
      String? icon,
      required String description,
      required List<Requires> requires}) = _CommitmentOption;

  factory CommitmentOption.fromJson(Map<String, dynamic> json) =>
      _$CommitmentOptionFromJson(json);
}

@freezed
class Requires with _$Requires {
  factory Requires(
      {required String id,
      required String label,
      required String description}) = _Requires;

  factory Requires.fromJson(Map<String, dynamic> json) =>
      _$RequiresFromJson(json);
}
