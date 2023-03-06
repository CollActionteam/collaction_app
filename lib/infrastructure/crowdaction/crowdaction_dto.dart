import 'package:equatable/equatable.dart';

import '../../domain/crowdaction/crowdaction.dart';

part 'models/commitment_dto.dart';
part 'models/images_dto.dart';
part 'models/location_dto.dart';

class CrowdActionDto extends Equatable {
  const CrowdActionDto({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.subcategory,
    required this.location,
    this.password,
    required this.participantCount,
    required this.images,
    required this.commitments,
    required this.status,
    required this.joinStatus,
    required this.endAt,
  });

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
    );
  }

  factory CrowdActionDto.fromJson(Map<String, dynamic> json) => CrowdActionDto(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        category: json['category'] as String,
        subcategory: json['subcategory'] as String?,
        location:
            LocationDto.fromJson(json['location'] as Map<String, dynamic>),
        password: json['password'] as String?,
        participantCount: json['participantCount'] as int,
        images: ImagesDto.fromJson(json['images'] as Map<String, dynamic>),
        commitments: (json['commitments'] as List<dynamic>)
            .map((dynamic e) =>
                CommitmentDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        status: (json['status'] as String).fromStatusJson,
        joinStatus: (json['joinStatus'] as String).fromJoinStatusJson,
        endAt: json['endAt'] as String,
      );

  final String id;

  final String title;

  final String description;

  final String category;

  final String? subcategory;

  final LocationDto location;

  final String? password;

  final int participantCount;

  final ImagesDto images;

  final List<CommitmentDto> commitments;

  final Status status;

  final JoinStatus joinStatus;

  final String endAt;

  CrowdActionDto copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? Function()? subcategory,
    LocationDto? location,
    String? Function()? password,
    int? participantCount,
    ImagesDto? images,
    List<CommitmentDto>? commitments,
    Status? status,
    JoinStatus? joinStatus,
    String? endAt,
    String? startAt,
  }) {
    return CrowdActionDto(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      subcategory: subcategory != null ? subcategory() : this.subcategory,
      location: location ?? this.location,
      password: password != null ? password() : this.password,
      participantCount: participantCount ?? this.participantCount,
      images: images ?? this.images,
      commitments: commitments ?? this.commitments,
      status: status ?? this.status,
      joinStatus: joinStatus ?? this.joinStatus,
      endAt: endAt ?? this.endAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        subcategory,
        location,
        password,
        participantCount,
        images,
        commitments,
        status,
        joinStatus,
        endAt,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'subcategory': subcategory,
        'location': location.toJson(),
        'password': password,
        'participantCount': participantCount,
        'images': images.toJson(),
        'commitments': commitments.map((e) => e.toJson()),
        'status': status.toJson,
        'joinStatus': joinStatus.toJson,
        'endAt': endAt,
      };
}
