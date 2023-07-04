part of '../core.dart';

/// Manage all url creation and building
// base static url
final baseStaticUrl =
    Uri.parse(dotenv.get('BASE_STATIC_ENDPOINT_URL')).resolve('\$web');

final nullStaticUrl = baseStaticUrl.resolve('null').toString();

extension ImageExtension on String {
  String get imageUrl => baseStaticUrl.resolve(this).toString();
}
