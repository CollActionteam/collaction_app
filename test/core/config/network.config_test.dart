import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/domain/participation/participation.dart';
import 'package:collaction_app/domain/profile/user_profile.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/crowdaction.fixtures.dart';
import '../../utils/participation.fixtures.dart';
import '../../utils/user.fixtures.dart';

void main() {
  const baseStaticUrl = 'https://staticurl.com/';

  setUpAll(() {
    dotenv.testLoad(
      fileInput: '''
                BASE_STATIC_ENDPOINT_URL=$baseStaticUrl\t
                ''',
    );
  });

  group('[userAvatar]', () {
    test(
        'should return user avatar url '
        'when the user profile is not null', () async {
      // arrange
      final userProfile = testUserProfile;
      // act
      final userAvatarUrl = userProfile.avatarUrl;

      // assert
      expect(
        userAvatarUrl,
        equals('$baseStaticUrl/${userProfile.profile.avatar}'),
      );
    });

    test(
        'should return null '
        'when the user profile is null', () async {
      // arrange
      const UserProfile? userProfile = null;

      // act
      final userAvatarUrl = userProfile?.avatarUrl;

      // assert
      expect(
        userAvatarUrl,
        equals(null),
      );
    });
  });

  group('[crowdActionBanner]', () {
    test(
        'should return crowdaction banner url '
        'when the crowdaction is not null', () async {
      // arrange
      final crowdAction = testCrowdAction;

      // act
      final crowdActionBannerUrl = crowdAction.bannerUrl;

      // assert
      expect(
        crowdActionBannerUrl,
        equals('$baseStaticUrl/${crowdAction.images.banner}'),
      );
    });

    test(
        'should return null crowdaction banner url '
        'when the crowdaction is null', () async {
      // arrange
      const CrowdAction? crowdAction = null;

      // act
      final crowdActionBannerUrl = crowdAction?.bannerUrl;

      // assert
      expect(
        crowdActionBannerUrl,
        equals(null),
      );
    });
  });

  group('[crowdActionCard]', () {
    test(
        'should return crowdaction card url '
        'when the crowdaction is not null', () async {
      // arrange
      final crowdAction = testCrowdAction;

      // act
      final crowdActionCardUrl = crowdAction.cardUrl;

      // assert
      expect(
        crowdActionCardUrl,
        equals('$baseStaticUrl/${crowdAction.images.card}'),
      );
    });

    test(
        'should return null crowdaction card url '
        'when the crowdaction is null', () async {
      // arrange
      const CrowdAction? crowdAction = null;

      // act
      final crowdActionCardUrl = crowdAction?.cardUrl;

      // assert
      expect(
        crowdActionCardUrl,
        equals(null),
      );
    });
  });

  group('[participationAvatar]', () {
    test(
        'should return participation avatar url '
        'when the participation is not null', () async {
      // arrange
      final participation = testParticipation;

      // act
      final participationAvatarUrl = participation.avatarUrl;

      // assert
      expect(
        participationAvatarUrl,
        equals('$baseStaticUrl/${participation.avatar}'),
      );
    });

    test(
        'should return null participation avatar url '
        'when the participation is null', () async {
      // arrange
      const Participation? participation = null;

      // act
      final participationAvatarUrl = participation?.avatarUrl;

      // assert
      expect(
        participationAvatarUrl,
        equals(null),
      );
    });
  });
}
