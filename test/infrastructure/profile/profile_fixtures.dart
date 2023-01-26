import 'package:collaction_app/domain/badge/badge.dart';
import 'package:collaction_app/domain/profile/profile.dart';
import 'package:collaction_app/infrastructure/badge/badge_dto.dart';
import 'package:collaction_app/infrastructure/profile/profile_dto.dart';

final tProfile = Profile(
    userId: 'userId',
    firstName: 'firstName',
    lastName: 'lastName',
    avatar: 'avatar',
    bio: 'bio',
    badges: [
      Badge(
        tier: BadgeTierEnum.diamond,
        awardType: AwardTypeEnum.all,
        minimumCheckIns: 0,
      ),
      Badge(
        tier: BadgeTierEnum.gold,
        awardType: AwardTypeEnum.tier,
        minimumCheckIns: 1,
      ),
    ]);

final tProfileDto = ProfileDto(
    userId: 'userId',
    firstName: 'firstName',
    lastName: 'lastName',
    avatar: 'avatar',
    bio: 'bio',
    badges: [
      BadgeDto(
        tier: BadgeTierEnum.diamond,
        awardType: AwardTypeEnum.all,
        minimumCheckIns: 0,
      ),
      BadgeDto(
        tier: BadgeTierEnum.gold,
        awardType: AwardTypeEnum.tier,
        minimumCheckIns: 1,
      ),
    ]);

final tProfileJson = {
  'userId': 'userId',
  'firstName': 'firstName',
  'lastName': 'lastName',
  'avatar': 'avatar',
  'bio': 'bio',
  "badges": [
    {"tier": "DIAMOND", "awardType": "ALL", "minimumCheckIns": 0},
    {"tier": "GOLD", "awardType": "TIER", "minimumCheckIns": 1}
  ]
};
