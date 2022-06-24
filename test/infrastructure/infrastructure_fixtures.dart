import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/infrastructure/crowdaction/crowdaction_dto.dart';

String generateEndDate(DateTime now) {
  return now.add(const Duration(days: 3)).toString();
}

String generateDateLimitJoin(DateTime now) {
  return now.add(const Duration(days: 2)).toString();
}

String generateStartDate(DateTime now) {
  return now.add(const Duration(days: 1)).toString();
}

final todaysDate = DateTime.now();
final currentDate = DateTime(todaysDate.year, todaysDate.month, todaysDate.day);

Map<String, dynamic> crowdactionDtoJson = {
  'crowdactionID': 'tID',
  'title': 'tTitle',
  'description': 'tDescription',
  'category': 'tCategory',
  'location': 'tLocation',
  'commitment_options': [commitmentOptionJson],
  'date_end': generateEndDate(currentDate),
  'date_limit_join': generateDateLimitJoin(currentDate),
  'date_start': generateStartDate(currentDate),
  'images': imagesDtoJson,
  'top_participants': [topParticipantJson],
  'participant_count': 0,
  'subcategory': 'tSubCategory',
};

CrowdActionDto tCrowdactionDto = CrowdActionDto(
  crowdactionID: 'tID',
  title: 'tTitle',
  description: 'tDescription',
  category: 'tCategory',
  location: 'tLocation',
  commitment_options: [tCommitmentOptionDto],
  date_end: generateEndDate(currentDate),
  date_limit_join: generateDateLimitJoin(currentDate),
  date_start: generateStartDate(currentDate),
  images: tImagesDto,
  top_participants: [tTopParticipantDto],
  participant_count: 0,
  subcategory: 'tSubCategory',
);

TopParticipantDto tTopParticipantDto = TopParticipantDto(
  userID: 'tUserId',
  name: 'tName',
);

Map<String, dynamic> topParticipantJson = {
  'userID': 'tUserId',
  'name': 'tName',
};

CommitmentOptionDto tCommitmentOptionDto = CommitmentOptionDto(
  id: 'no-beef',
  label: 'tLabel',
  description: 'tDescription',
);

Map<String, dynamic> commitmentOptionJson = {
  'id': 'no-beef',
  'label': 'tLabel',
  'description': 'tDescription',
};

Map<String, dynamic> imagesDtoJson = {
  'card': 'tImageDtoCard',
  'banner': 'tImageDtoBanner',
};

ImagesDto tImagesDto = ImagesDto(
  card: 'tImageDtoCard',
  banner: 'tImageDtoBanner',
);

// Map<String, dynamic> tCrowdactionJson = {};

CrowdAction tCrowdAction = CrowdAction(
  crowdactionID: 'tID',
  title: 'tTitle',
  description: 'tDescription',
  category: 'tCategory',
  location: 'tLocation',
  commitmentOptions: [tCommitmentOptionDto.toDomain()],
  dateEnd: DateTime.parse(generateEndDate(currentDate)),
  dateLimitJoin: DateTime.parse(generateDateLimitJoin(currentDate)),
  dateStart: DateTime.parse(generateStartDate(currentDate)),
  images: tImagesDto.toDomain(),
  topParticipants: [tTopParticipantDto.toDomain()],
  participantCount: 0,
  subCategory: '',
);
