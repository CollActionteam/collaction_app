import 'package:collaction_app/core/core.dart';
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
      final userAvatarUrl = NetworkConfig.userAvatar(userProfile);

      // assert
      expect(
        userAvatarUrl,
        equals('$baseStaticUrl/${userProfile.profile.avatar}'),
      );
    });

    test(
        'should return null '
        'when the user profile is null', () async {
      // act
      final userAvatarUrl = NetworkConfig.userAvatar(null);

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
      final crowdActionBannerUrl = NetworkConfig.crowdActionBanner(crowdAction);

      // assert
      expect(
        crowdActionBannerUrl,
        equals('$baseStaticUrl/${crowdAction.images.banner}'),
      );
    });

    test(
        'should return null inclusive crowdaction banner url '
        'when the crowdaction is null', () async {
      // act
      final crowdActionBannerUrl = NetworkConfig.crowdActionBanner(null);

      // assert
      // TODO(isaac): Could this be buggy
      expect(
        crowdActionBannerUrl,
        equals('$baseStaticUrl/null'),
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
      final crowdActionCardUrl = NetworkConfig.crowdActionCard(crowdAction);

      // assert
      expect(
        crowdActionCardUrl,
        equals('$baseStaticUrl/${crowdAction.images.card}'),
      );
    });

    test(
        'should return null inclusive crowdaction card url '
        'when the crowdaction is null', () async {
      // act
      final crowdActionCardUrl = NetworkConfig.crowdActionCard(null);

      // assert
      // TODO(isaac): Could this be buggy
      expect(
        crowdActionCardUrl,
        equals('$baseStaticUrl/null'),
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
      final participationAvatarUrl =
          NetworkConfig.participationAvatar(participation);

      // assert
      expect(
        participationAvatarUrl,
        equals('$baseStaticUrl/${participation.avatar}'),
      );
    });

    test(
        'should return null inclusive participation avatar url '
        'when the participation is null', () async {
      // act
      final participationAvatarUrl = NetworkConfig.participationAvatar(null);

      // assert
      // TODO(isaac): Could this be buggy
      expect(
        participationAvatarUrl,
        equals('$baseStaticUrl/null'),
      );
    });
  });
}
