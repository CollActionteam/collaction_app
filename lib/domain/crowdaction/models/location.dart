part of '../crowdaction.dart';

class Location extends Equatable {
  const Location({
    required this.code,
    required this.name,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        code: json['code'] as String,
        name: json['name'] as String,
      );

  final String code;

  final String name;

  Location copyWith({
    String? code,
    String? name,
  }) {
    return Location(
      code: code ?? this.code,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [
        code,
        name,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'name': name,
      };
}
