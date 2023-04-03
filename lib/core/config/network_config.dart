part of '../core.dart';

/// Manage all url creation and building
// base static url
final baseStaticUrl = dotenv.get('BASE_STATIC_ENDPOINT_URL');

final nullStaticUrl = '$baseStaticUrl/${null}';

extension ImageExtension on String {
  String get imageUrl => '$baseStaticUrl/$this';
}
