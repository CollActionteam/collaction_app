import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/core/page_info.dart';

part 'page_info_dto.freezed.dart';
part 'page_info_dto.g.dart';

@freezed
class PageInfoDto with _$PageInfoDto {
  const PageInfoDto._();

  const factory PageInfoDto({
    required int page,
    required int pageSize,
    required int totalPages,
    required int totalItems,
  }) = _PageInfoDto;

  factory PageInfoDto.fromJson(Map<String, dynamic> json) =>
      _$PageInfoDtoFromJson(json);

  PageInfo toDomain() => PageInfo(
        page: page,
        pageSize: pageSize,
        totalPages: totalPages,
        totalItems: totalItems,
      );
}
