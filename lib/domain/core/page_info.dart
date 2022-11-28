import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_info.freezed.dart';

@freezed
class PageInfo with _$PageInfo {
  const PageInfo._();

  const factory PageInfo({
    required int page,
    required int pageSize,
    required int totalPages,
    required int totalItems,
  }) = _PageInfo;
}
