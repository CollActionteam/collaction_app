part of '../crowdaction_dto.dart';

class ImagesDto extends Equatable {
  const ImagesDto({
    required this.card,
    required this.banner,
  });

  Images toDomain() {
    return Images(
      card: card,
      banner: banner,
    );
  }

  factory ImagesDto.fromJson(Map<String, dynamic> json) => ImagesDto(
        card: json['card'] as String,
        banner: json['banner'] as String,
      );

  final String card;

  final String banner;

  ImagesDto copyWith({
    String? card,
    String? banner,
  }) {
    return ImagesDto(
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
