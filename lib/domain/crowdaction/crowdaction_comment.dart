import 'package:equatable/equatable.dart';

class CrowdactionComment extends Equatable {

  const CrowdactionComment({ 
    required this.crowdactionId,
    required this.content,
    required this.userId,
    required this.createdAt,
    this.comments,
    required this.likes,
    required this.likedByMe,
    this.flagged,
    this.flags,
  });

  factory CrowdactionComment.fromJson(Map<String, dynamic> json) => CrowdactionComment(
        crowdactionId: json['crowdactionId'] as String,
        content: json['content'] as String,
        userId: json['userId'] as String,
        createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '')!,
        comments: json['comments'] as List<String>?,
        likes: json['likes'] as int,
        likedByMe: json['likedByMe'] as bool,
        flagged: json['flagged'] as bool?,
        flags: json['flags'] as List<String>?,
      );

  /// A description for crowdactionId
  final String crowdactionId;

  /// A description for content
  final String content;

  /// A description for userId
  final String userId;

  /// A description for createdAt
  final DateTime createdAt;

  /// A description for comments
  final List<String>? comments;

  /// A description for likes
  final int likes;

  /// A description for likedByMe
  final bool likedByMe;

  /// A description for flagged
  final bool? flagged;

  /// A description for flags
  final List<String>? flags;

  CrowdactionComment copyWith({ 
    String? crowdactionId,
    String? content,
    String? userId,
    DateTime? createdAt,
    List<String>? Function()? comments,
    int? likes,
    bool? likedByMe,
    bool? Function()? flagged,
    List<String>? Function()? flags,
  }) {
    return CrowdactionComment(
      crowdactionId: crowdactionId ?? this.crowdactionId,
      content: content ?? this.content,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
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
        content,
        userId,
        createdAt,
        comments,
        likes,
        likedByMe,
        flagged,
        flags,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{ 
        'crowdactionId': crowdactionId,
        'content': content,
        'userId': userId,
        'createdAt': createdAt,
        'comments': comments,
        'likes': likes,
        'likedByMe': likedByMe,
        'flagged': flagged,
        'flags': flags,
      };
}
