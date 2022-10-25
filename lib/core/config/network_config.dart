part of '../core.dart';

/// Manage all url creation and building
// base static url
final _baseStaticUrl = dotenv.get('BASE_STATIC_ENDPOINT_URL');

extension UserProfileUrlX on UserProfile? {
  // User profile avatar url
  String? get avatarUrl {
    if (this?.profile.avatar != null) {
      return '$_baseStaticUrl/${this?.profile.avatar}';
    }

    return null;
  }
}

extension CrowdActionUrlX on CrowdAction? {
  // Crowdaction banner url
  String get bannerUrl {
    return '$_baseStaticUrl/${this?.images.banner}';
  }

  // Crowdaction card url
  String get cardUrl {
    return '$_baseStaticUrl/${this?.images.card}';
  }
}

extension ParticipationUrlX on Participation? {
  // Participation avatar url
  String get avatarUrl {
    return '$_baseStaticUrl/${this?.avatar}';
  }
}
