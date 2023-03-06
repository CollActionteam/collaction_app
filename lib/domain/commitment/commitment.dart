import 'package:equatable/equatable.dart';

class Commitment extends Equatable {
  const Commitment({
    required this.id,
    required this.title,
    this.description,
    required this.checked,
    this.icon,
  });

  factory Commitment.fromJson(Map<String, dynamic> json) => Commitment(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String?,
        checked: json['checked'] as bool,
        icon: json['icon'] as String?,
      );

  final int id;

  final String title;

  final String? description;

  final bool checked;

  final String? icon;

  Commitment copyWith({
    int? id,
    String? title,
    String? Function()? description,
    bool? checked,
    String? Function()? icon,
  }) {
    return Commitment(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description != null ? description() : this.description,
      checked: checked ?? this.checked,
      icon: icon != null ? icon() : this.icon,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        checked,
        icon,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'description': description,
        'checked': checked,
        'icon': icon,
      };
}
