part of '../crowdaction_dto.dart';

class CommitmentDto extends Equatable {
  const CommitmentDto({
    required this.label,
    this.description,
    required this.points,
    required this.blocks,
    required this.id,
    this.icon,
  });

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

  factory CommitmentDto.fromJson(Map<String, dynamic> json) => CommitmentDto(
        label: json['label'] as String,
        description: json['description'] as String?,
        points: json['points'] as int,
        blocks: json['blocks'] as List<String>,
        id: json['_id'] as String,
        icon: json['icon'] as String?,
      );

  final String label;

  final String? description;

  final int points;

  final List<String> blocks;

  final String id;

  final String? icon;

  CommitmentDto copyWith({
    String? label,
    String? Function()? description,
    int? points,
    List<String>? blocks,
    String? id,
    String? Function()? icon,
  }) {
    return CommitmentDto(
      label: label ?? this.label,
      description: description != null ? description() : this.description,
      points: points ?? this.points,
      blocks: blocks ?? this.blocks,
      id: id ?? this.id,
      icon: icon != null ? icon() : this.icon,
    );
  }

  @override
  List<Object?> get props => [
        label,
        description,
        points,
        blocks,
        id,
        icon,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'label': label,
        'description': description,
        'points': points,
        'blocks': blocks,
        '_id': id,
        'icon': icon,
      };
}
