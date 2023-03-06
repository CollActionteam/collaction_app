import 'package:equatable/equatable.dart';

import '../../domain/crowdaction/crowdaction_comment.dart';

class CrowdactionCommentDto extends Equatable {
  const CrowdactionCommentDto({
    required this.crowdactionId,
    required this.userId,
    required this.createdAt,
    required this.content,
    this.comments,
    required this.likes,
    required this.likedByMe,
    this.flagged,
    this.flags,
  });

  factory CrowdactionCommentDto.fromJson(Map<String, dynamic> json) =>
      CrowdactionCommentDto(
        crowdactionId: json['crowdaction_id'] as String,
        userId: json['user_id'] as String,
        createdAt: json['created_at'] as DateTime,
        content: json['content'] as String,
        comments: (json['comments'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
        likes: json['likes'] as int,
        likedByMe: json['liked_by_me'] as bool,
        flagged: json['flagged'] as bool?,
        flags: (json['flags'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
      );

  final String crowdactionId;

  final String userId;

  final DateTime createdAt;

  final String content;

  final List<String>? comments;

  final int likes;

  final bool likedByMe;

  final bool? flagged;

  final List<String>? flags;

  CrowdactionCommentDto copyWith({
    String? crowdactionId,
    String? userId,
    DateTime? createdAt,
    String? content,
    List<String>? Function()? comments,
    int? likes,
    bool? likedByMe,
    bool? Function()? flagged,
    List<String>? Function()? flags,
  }) {
    return CrowdactionCommentDto(
      crowdactionId: crowdactionId ?? this.crowdactionId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      content: content ?? this.content,
      comments: comments != null ? comments() : this.comments,
      likes: likes ?? this.likes,
      likedByMe: likedByMe ?? this.likedByMe,
      flagged: flagged != null ? flagged() : this.flagged,
      flags: flags != null ? flags() : this.flags,
    );
  }

  @override
  List<Object?> get props => [
        crowdactionId,
        userId,
        createdAt,
        content,
        comments,
        likes,
        likedByMe,
        flagged,
        flags,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'crowdaction_id': crowdactionId,
        'user_id': userId,
        'created_at': createdAt,
        'content': content,
        'comments': comments,
        'likes': likes,
        'liked_by_me': likedByMe,
        'flagged': flagged,
        'flags': flags,
      };

  CrowdactionComment toDomain() {
    return CrowdactionComment(
      crowdactionId: crowdactionId,
      content: content,
      userId: userId,
      createdAt: createdAt,
      likes: likes,
      likedByMe: likedByMe,
    );
  }
}
