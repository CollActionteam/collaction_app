part of '../core.dart';

/// Manage all url creation and building
// ignore_for_file: avoid_classes_with_only_static_members
class NetworkConfig {
  // base static url
  static final _baseStaticUrl = dotenv.get('BASE_STATIC_ENDPOINT_URL');

  // User profile avatar url
  static String? userAvatar(UserProfile? userProfile) {
    if (userProfile?.profile.avatar != null) {
      return '$_baseStaticUrl/${userProfile?.profile.avatar}';
    }

    return null;
  }

  // Crowdaction banner url
  static String crowdActionBanner(CrowdAction? crowdAction) {
    return '$_baseStaticUrl/${crowdAction?.images.banner}';
  }

  // Crowdaction card url
  static String crowdActionCard(CrowdAction? crowdAction) {
    return '$_baseStaticUrl/${crowdAction?.images.card}';
  }

  // Participation avatar url
  static String participationAvatar(Participation? participation) {
    return '$_baseStaticUrl/${participation?.avatar}';
  }
}
