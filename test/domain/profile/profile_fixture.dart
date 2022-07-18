import 'package:collaction_app/domain/profile/profile.dart';
import 'package:collaction_app/infrastructure/profile/profile_dto.dart';

const cProfileDtoJson = {
  'bio': "I am Jack!",
};

const cProfileDtoFromJson = ProfileDto(
  userId: "123456",
  firstName: "Jack",
  bio: "I am Jack!",
  avatar: 'avatar',
  phone: '+123456789',
);

const cProfileFromJson = Profile(
  userId: "123456",
  firstName: "Jack",
  bio: "I am Jack!",
  avatar: 'avatar',
  phone: '+123456789',
);
