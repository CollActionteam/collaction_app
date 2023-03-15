import 'package:collaction_app/domain/core/location.dart';
import 'package:collaction_app/domain/profile/profile.dart';
import 'package:collaction_app/infrastructure/core/location_dto.dart';
import 'package:collaction_app/infrastructure/profile/profile_dto.dart';

const cProfileDtoJson = {
  'userId': '123456',
  'firstName': 'John',
  'lastName': 'Doe',
  'bio': "I am Jack!",
  'avatar': 'avatar',
  'phone': '+31612345678',
};

const cProfileDtoFromJson = ProfileDto(
  userId: "123456",
  firstName: 'John',
  lastName: 'Doe',
  bio: "I am Jack!",
  avatar: 'avatar',
  location: LocationDto(
    code: 'NL',
    name: 'The Netherlands',
  ),
);

const cProfileFromJson = Profile(
  userId: "123456",
  firstName: 'John',
  lastName: 'Doe',
  bio: "I am Jack!",
  avatar: 'avatar',
  location: Location(
    code: 'NL',
    name: 'The Netherlands',
  ),
);
