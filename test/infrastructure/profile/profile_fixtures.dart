import 'package:collaction_app/domain/core/location.dart';
import 'package:collaction_app/domain/profile/profile.dart';
import 'package:collaction_app/infrastructure/core/location_dto.dart';
import 'package:collaction_app/infrastructure/profile/profile_dto.dart';

final tProfile = Profile(
  userId: 'userId',
  firstName: 'firstName',
  lastName: 'lastName',
  avatar: 'avatar',
  bio: 'bio',
  location: Location(
    code: 'NL',
    name: 'The Netherlands',
  ),
);

final tProfileDto = ProfileDto(
  userId: 'userId',
  firstName: 'firstName',
  lastName: 'lastName',
  avatar: 'avatar',
  bio: 'bio',
  location: LocationDto(
    code: 'NL',
    name: 'The Netherlands',
  ),
);

final tProfileJson = {
  'userId': 'userId',
  'firstName': 'firstName',
  'lastName': 'lastName',
  'avatar': 'avatar',
  'bio': 'bio',
};
