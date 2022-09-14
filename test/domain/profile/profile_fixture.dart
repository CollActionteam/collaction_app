import 'package:collaction_app/domain/profile/profile.dart';
import 'package:collaction_app/infrastructure/profile/profile_dto.dart';

const cProfileDtoJson = {
  'userId': '123456',
  'firstName': 'Jack',
  'bio': "I am Jack!",
  'avatar': 'avatar',
  'phone': '+31612345678',
};

const cProfileDtoFromJson = ProfileDto(
  userId: "123456",
  firstName: "Jack",
  lastName: "Ma",
  bio: "I am Jack!",
  avatar: 'avatar',
);

const cProfileFromJson = Profile(
  userId: "123456",
  firstName: "Jack",
  lastName: "Ma",
  bio: "I am Jack!",
  avatar: 'avatar',
);
