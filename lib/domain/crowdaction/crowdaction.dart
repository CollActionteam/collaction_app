import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../presentation/core/collaction_icons.dart';
import '../../presentation/core/ionicons_utils.dart';
import '../../presentation/shared_widgets/secondary_chip.dart';

part 'models/commitment.dart';
part 'models/images.dart';
part 'models/location.dart';
part 'models/statuses.dart';

class CrowdAction extends Equatable {
  const CrowdAction({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.subcategory,
    required this.location,
    required this.slug,
    this.password,
    required this.participantCount,
    required this.images,
    required this.commitments,
    required this.status,
    required this.joinStatus,
    required this.startAt,
    required this.endAt,
  });

  factory CrowdAction.fromJson(Map<String, dynamic> json) => CrowdAction(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        category: json['category'] as String,
        subcategory: json['subcategory'] as String?,
        location: Location.fromJson(json['location'] as Map<String, dynamic>),
        slug: json['slug'] as String,
        password: json['password'] as String?,
        participantCount: json['participantCount'] as int,
        images: Images.fromJson(json['images'] as Map<String, dynamic>),
        commitments: (json['commitments'] as List<dynamic>)
            .map((dynamic e) => Commitment.fromJson(e as Map<String, dynamic>))
            .toList(),
        status: (json['status'] as String).fromStatusJson,
        joinStatus: (json['joinStatus'] as String).fromJoinStatusJson,
        startAt: json['startAt'] as DateTime,
        endAt: json['endAt'] as DateTime,
      );

  final String id;

  final String title;

  final String description;

  final String category;

  final String? subcategory;

  final Location location;

  final String slug;

  final String? password;

  final int participantCount;

  final Images images;

  final List<Commitment> commitments;

  final Status status;

  final JoinStatus joinStatus;

  final DateTime startAt;

  final DateTime endAt;

  CrowdAction copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? Function()? subcategory,
    Location? location,
    String? slug,
    String? Function()? password,
    int? participantCount,
    Images? images,
    List<Commitment>? commitments,
    Status? status,
    JoinStatus? joinStatus,
    DateTime? startAt,
    DateTime? endAt,
  }) {
    return CrowdAction(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      subcategory: subcategory != null ? subcategory() : this.subcategory,
      location: location ?? this.location,
      slug: slug ?? this.slug,
      password: password != null ? password() : this.password,
      participantCount: participantCount ?? this.participantCount,
      images: images ?? this.images,
      commitments: commitments ?? this.commitments,
      status: status ?? this.status,
      joinStatus: joinStatus ?? this.joinStatus,
      startAt: startAt ?? this.startAt,
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
        slug,
        password,
        participantCount,
        images,
        commitments,
        status,
        joinStatus,
        startAt,
        endAt,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'subcategory': subcategory,
        'location': location.toJson(),
        'slug': slug,
        'password': password,
        'participantCount': participantCount,
        'images': images.toJson(),
        'commitments': commitments.map((e) => e.toJson()),
        'status': status.toJson,
        'joinStatus': joinStatus.toJson,
        'startAt': startAt,
        'endAt': endAt,
      };

  bool get hasParticipants => participantCount > 0;

  bool get hasPassword => password != null && password!.isNotEmpty;

  List<Widget> toChips() {
    return [
      SecondaryChip(text: category),
      if (subcategory != null) ...[SecondaryChip(text: subcategory!)],
    ];
  }

  bool get isOpen => joinStatus == JoinStatus.open;
  bool get isRunning => status == Status.started;
  bool get isClosed => status == Status.ended;
  bool get isWaiting => status == Status.waiting;

  String get statusChipLabel => isOpen
      ? 'Now open'
      : isRunning
          ? 'Currently running'
          : isWaiting
              ? 'Starting soon'
              : 'Finished';

  // Crowdaction banner url
  String get bannerUrl => '$baseStaticUrl/${images.banner}';

  // Crowdaction card url
  String get cardUrl => '$baseStaticUrl/${images.card}';
}
