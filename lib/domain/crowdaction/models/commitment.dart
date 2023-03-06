part of '../crowdaction.dart';

class Commitment extends Equatable {
  const Commitment({
    required this.label,
    this.description,
    required this.points,
    required this.blocks,
    required this.id,
    this.iconId,
  });

  factory Commitment.fromJson(Map<String, dynamic> json) => Commitment(
        label: json['label'] as String,
        description: json['description'] as String?,
        points: json['points'] as int,
        blocks: json['blocks'] as List<String>,
        id: json['id'] as String,
        iconId: json['iconId'] as String?,
      );

  final String label;

  final String? description;

  final int points;

  final List<String> blocks;

  final String id;

  final String? iconId;

  Commitment copyWith({
    String? label,
    String? Function()? description,
    int? points,
    List<String>? blocks,
    String? id,
    String? Function()? iconId,
  }) {
    return Commitment(
      label: label ?? this.label,
      description: description != null ? description() : this.description,
      points: points ?? this.points,
      blocks: blocks ?? this.blocks,
      id: id ?? this.id,
      iconId: iconId != null ? iconId() : this.iconId,
    );
  }

  @override
  List<Object?> get props => [
        label,
        description,
        points,
        blocks,
        id,
        iconId,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'label': label,
        'description': description,
        'points': points,
        'blocks': blocks,
        'id': id,
        'iconId': iconId,
      };

  IconData get icon => iconId != null
      ? IconUtil.fromString(iconId!)
      : CollactionIcons.collaction;
}
