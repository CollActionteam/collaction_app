import 'package:collaction_app/domain/profile/profile.dart';
import 'package:collaction_app/infrastructure/profile/profile_dto.dart';

const cProfileDtoJson = {
  'bio': "I am Jack!",
};

const cProfileDtoFromJson = ProfileDto(bio: "I am Jack!");

const cProfileFromJson = Profile(bio: "I am Jack!");
