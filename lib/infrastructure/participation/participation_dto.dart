import 'package:equatable/equatable.dart';

import '../../domain/participation/participation.dart';

class ParticipationDto extends Equatable {
    const ParticipationDto({
    required this.id,
    required this.crowdActionId,
    required this.fullName,
    required this.avatar,
    required this.userId,
    required this.commitments,
    required this.joinDate,
    required this.dailyCheckIns,
  });

  Participation toDomain() {
    return Participation(
      id: id,
      crowdActionId: crowdActionId,
      userId: userId,
      fullName: fullName,
      avatar: avatar,
      commitments: commitments,
      joinDate: DateTime.parse(joinDate),
      dailyCheckIns: dailyCheckIns,
    );
  }

    factory ParticipationDto.fromJson(Map<String, dynamic> json) =>
      ParticipationDto(
        id: json['id'] as String,
        crowdActionId: json['crowdActionId'] as String,
        fullName: json['fullName'] as String,
        avatar: json['avatar'] as String,
        userId: json['userId'] as String,
        commitments: json['commitments'] as List<String>,
        joinDate: json['joinDate'] as String,
        dailyCheckIns: json['dailyCheckIns'] as int,
      );

    final String id;

    final String crowdActionId;

    final String fullName;

    final String avatar;

    final String userId;

    final List<String> commitments;

    final String joinDate;

    final int dailyCheckIns;

    ParticipationDto copyWith({
    String? id,
    String? crowdActionId,
    String? fullName,
    String? avatar,
    String? userId,
    List<String>? commitments,
    String? joinDate,
    int? dailyCheckIns,
  }) {
    return ParticipationDto(
      id: id ?? this.id,
      crowdActionId: crowdActionId ?? this.crowdActionId,
      fullName: fullName ?? this.fullName,
      avatar: avatar ?? this.avatar,
      userId: userId ?? this.userId,
      commitments: commitments ?? this.commitments,
      joinDate: joinDate ?? this.joinDate,
      dailyCheckIns: dailyCheckIns ?? this.dailyCheckIns,
    );
  }

  @override
  List<Object?> get props => [
        id,
        crowdActionId,
        fullName,
        avatar,
        userId,
        commitments,
        joinDate,
        dailyCheckIns,
      ];

    Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'crowdActionId': crowdActionId,
        'fullName': fullName,
        'avatar': avatar,
        'userId': userId,
        'commitments': commitments,
        'joinDate': joinDate,
        'dailyCheckIns': dailyCheckIns,
      };
}
