part of '../crowdaction.dart';

class Images extends Equatable {
  const Images({
    required this.card,
    required this.banner,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        card: json['card'] as String,
        banner: json['banner'] as String,
      );

  final String card;

  final String banner;

  Images copyWith({
    String? card,
    String? banner,
  }) {
    return Images(
      card: card ?? this.card,
      banner: banner ?? this.banner,
    );
  }

  @override
  List<Object?> get props => [
        card,
        banner,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'card': card,
        'banner': banner,
      };
}
