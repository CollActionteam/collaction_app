import 'package:equatable/equatable.dart';

import '../../domain/participation/paginated_participations.dart';
import '../core/page_info_dto.dart';
import 'participation_dto.dart';

class PaginatedParticipationsDto extends Equatable {
  const PaginatedParticipationsDto({
    required this.participations,
    required this.pageInfo,
  });

  PaginatedParticipations toDomain() => PaginatedParticipations(
        participations: participations.map((e) => e.toDomain()).toList(),
        pageInfo: pageInfo.toDomain(),
      );

  factory PaginatedParticipationsDto.fromJson(Map<String, dynamic> json) =>
      PaginatedParticipationsDto(
        participations: (json['participations'] as List<dynamic>)
            .map((dynamic e) =>
                ParticipationDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        pageInfo:
            PageInfoDto.fromJson(json['pageInfo'] as Map<String, dynamic>),
      );

  final List<ParticipationDto> participations;

  final PageInfoDto pageInfo;

  PaginatedParticipationsDto copyWith({
    List<ParticipationDto>? participations,
    PageInfoDto? pageInfo,
  }) {
    return PaginatedParticipationsDto(
      participations: participations ?? this.participations,
      pageInfo: pageInfo ?? this.pageInfo,
    );
  }

  @override
  List<Object?> get props => [
        participations,
        pageInfo,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'participations': participations,
        'pageInfo': pageInfo,
      };
}
