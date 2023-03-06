import 'package:equatable/equatable.dart';

import '../../domain/core/page_info.dart';

class PageInfoDto extends Equatable {
  const PageInfoDto({
    required this.page,
    required this.pageSize,
    required this.totalPages,
    required this.totalItems,
  });

  factory PageInfoDto.fromJson(Map<String, dynamic> json) => PageInfoDto(
        page: json['page'] as int,
        pageSize: json['pageSize'] as int,
        totalPages: json['totalPages'] as int,
        totalItems: json['totalItems'] as int,
      );

  final int page;

  final int pageSize;

  final int totalPages;

  final int totalItems;

  PageInfoDto copyWith({
    int? page,
    int? pageSize,
    int? totalPages,
    int? totalItems,
  }) {
    return PageInfoDto(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
    );
  }

  @override
  List<Object?> get props => [
        page,
        pageSize,
        totalPages,
        totalItems,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
        'totalPages': totalPages,
        'totalItems': totalItems,
      };

  PageInfo toDomain() => PageInfo(
        page: page,
        pageSize: pageSize,
        totalPages: totalPages,
        totalItems: totalItems,
      );
}
