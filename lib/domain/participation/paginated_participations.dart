import 'package:equatable/equatable.dart';

import '../core/page_info.dart';
import 'participation.dart';

class PaginatedParticipations extends Equatable {
  const PaginatedParticipations({
    required this.participations,
    required this.pageInfo,
  });

  factory PaginatedParticipations.fromJson(Map<String, dynamic> json) =>
      PaginatedParticipations(
        participations: (json['participations'] as List<dynamic>)
            .map((dynamic e) =>
                Participation.fromJson(e as Map<String, dynamic>))
            .toList(),
        pageInfo: PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      );

  final List<Participation> participations;

  final PageInfo pageInfo;

  PaginatedParticipations copyWith({
    List<Participation>? participations,
    PageInfo? pageInfo,
  }) {
    return PaginatedParticipations(
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
        'participations': participations.map((e) => e.toJson()),
        'pageInfo': pageInfo,
      };
}
