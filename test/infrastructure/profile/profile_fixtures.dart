import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/domain/profile/profile.dart';
import 'package:collaction_app/infrastructure/profile/profile_dto.dart';

final tProfile = Profile(
    userId: 'userId',
    firstName: 'firstName',
    lastName: 'lastName',
    avatar: 'avatar',
    bio: 'bio',
    location: Location(code: "NL", name: "Netherlands"));

final tProfileDto = ProfileDto(
  userId: 'userId',
  firstName: 'firstName',
  lastName: 'lastName',
  avatar: 'avatar',
  bio: 'bio',
  location: Location(code: "NL", name: "Netherlands"),
);

final tProfileJson = {
  'userId': 'userId',
  'firstName': 'firstName',
  'lastName': 'lastName',
  'avatar': 'avatar',
  'bio': 'bio',
};
