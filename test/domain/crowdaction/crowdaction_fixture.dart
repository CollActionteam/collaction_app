import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/infrastructure/crowdaction/crowdaction_dto.dart';
import 'package:collaction_app/presentation/core/collaction_icons.dart';
import 'package:collaction_app/presentation/shared_widgets/secondary_chip.dart';

const cCrowdActionPasswordToChips = [
  SecondaryChip(text: 'food'),
  SecondaryChip(text: 'sustainability'),
];

const cCrowdActionNoPasswordToChips = [
  SecondaryChip(text: 'food'),
];

final cImagesDto = ImagesDto(banner: '_', card: '_');
const cImages = Images(banner: '_', card: '_');
const cImagesJson = {'banner': '_', 'card': '_'};

final cTopParticipantOneDto =
    TopParticipantDto(name: 'John Doe', userID: '0001');
final cTopParticipantTwoDto =
    TopParticipantDto(name: 'Jane Doe', userID: '0002');
final cTopParticipantThreeDto =
    TopParticipantDto(name: 'Adam Doe', userID: '0003');
final cTopParticipantFourDto =
    TopParticipantDto(name: 'Mona Doe', userID: '0004');

final cTopParticipantOne = TopParticipant(name: 'John Doe', userId: '0001');
final cTopParticipantTwo = TopParticipant(name: 'Jane Doe', userId: '0002');
final cTopParticipantThree = TopParticipant(name: 'Adam Doe', userId: '0003');
final cTopParticipantFour = TopParticipant(name: 'Mona Doe', userId: '0004');

const cTopParticipantOneJson = {'name': 'John Doe', 'userId': '0001'};
const cTopParticipantTwoJson = {'name': 'Jane Doe', 'userId': '0002'};
const cTopParticipantThreeJson = {'name': 'Adam Doe', 'userId': '0003'};
const cTopParticipantFourJson = {'name': 'Mona Doe', 'userId': '0004'};

final cCommitmentOptionDto = CommitmentOptionDto(
  id: 'vegetarian',
  label: 'Becoming vegetarian',
  description: 'I will not eat any meat from any animal (including fish).',
  requires: [
    CommitmentOptionDto(
      id: 'no-beef',
      label: 'Not eating beef',
      description: 'I will avoid eating beef (Goodbye stake).',
    ),
  ],
);

final cCommitmentOption = CommitmentOption(
  id: 'vegetarian',
  label: 'Becoming vegetarian',
  description: 'I will not eat any meat from any animal (including fish).',
  requires: [
    CommitmentOption(
      id: 'no-beef',
      label: 'Not eating beef',
      description: 'I will avoid eating beef (Goodbye stake).',
    ),
  ],
);

const cCommitmentOptionIcon = CollactionIcons.vegetarian;

const cCommitmentOptionJson = {
  "id": "vegetarian",
  "label": "Becoming vegetarian",
  "description": "I will not eat any meat from any animal (including fish).",
  "requires": [
    {
      "id": "no-beef",
      "label": "Not eating beef",
      "description": "I will avoid eating beef (Goodbye stake)."
    },
  ],
};

final cCrowdActionPasswordDto = CrowdActionDto(
  crowdactionID: '0001',
  title: 'Hello World!',
  description: 'This is a CrowdAction',
  commitment_options: [cCommitmentOptionDto],
  category: 'food',
  subcategory: 'sustainability',
  date_end: '2030-01-01',
  date_limit_join: '2030-01-01',
  date_start: '2020-01-01',
  images: cImagesDto,
  location: 'Amsterdam',
  participant_count: 4,
  top_participants: [
    cTopParticipantOneDto,
    cTopParticipantTwoDto,
    cTopParticipantThreeDto,
  ],
  password_join: '123456',
);

final cCrowdActionPassword = CrowdAction(
  crowdactionID: '0001',
  title: 'Hello World!',
  description: 'This is a CrowdAction',
  commitmentOptions: [cCommitmentOption],
  category: 'food',
  subCategory: 'sustainability',
  dateEnd: DateTime(2030),
  dateLimitJoin: DateTime(2030),
  dateStart: DateTime(2020),
  images: cImages,
  location: 'Amsterdam',
  participantCount: 4,
  topParticipants: [
    cTopParticipantOne,
    cTopParticipantTwo,
    cTopParticipantThree
  ],
  passwordJoin: '123456',
);

const cCrowdActionPasswordJson = {
  'crowdactionID': '0001',
  'title': 'Hello World!',
  'description': 'This is a CrowdAction',
  'commitment_options': [
    {
      "id": "vegetarian",
      "label": "Becoming vegetarian",
      "description":
          "I will not eat any meat from any animal (including fish).",
      "requires": [
        {
          "id": "no-beef",
          "label": "Not eating beef",
          "description": "I will avoid eating beef (Goodbye stake)."
        },
      ],
    },
  ],
  'category': 'food',
  'subcategory': 'sustainability',
  'date_end': '2030-01-01',
  'date_limit_join': '2030-01-01',
  'date_start': '2020-01-01',
  'images': cImagesJson,
  'location': 'Amsterdam',
  'participant_count': 4,
  'top_participants': [
    cTopParticipantOneJson,
    cTopParticipantTwoJson,
    cTopParticipantThreeJson,
  ],
  'password_join': '123456',
};

final cCrowdActionNoPasswordDto = CrowdActionDto(
  crowdactionID: '0001',
  title: 'Hello World!',
  description: 'This is a CrowdAction',
  commitment_options: [cCommitmentOptionDto],
  category: 'food',
  date_end: '2021-01-01',
  date_limit_join: '2021-01-01',
  date_start: '2020-01-01',
  images: cImagesDto,
  location: 'Amsterdam',
  participant_count: 0,
  top_participants: [
    cTopParticipantOneDto,
    cTopParticipantTwoDto,
    cTopParticipantThreeDto,
  ],
);

final cCrowdActionNoPassword = CrowdAction(
  crowdactionID: '0001',
  title: 'Hello World!',
  description: 'This is a CrowdAction',
  commitmentOptions: [cCommitmentOption],
  category: 'food',
  dateEnd: DateTime(2021),
  dateLimitJoin: DateTime(2021),
  dateStart: DateTime(2020),
  images: cImages,
  location: 'Amsterdam',
  participantCount: 0,
  topParticipants: [
    cTopParticipantOne,
    cTopParticipantTwo,
    cTopParticipantThree
  ],
);

const cCrowdActionNoPasswordJson = {
  'crowdactionID': '0001',
  'title': 'Hello World!',
  'description': 'This is a CrowdAction',
  'commitment_options': [
    {
      "id": "vegetarian",
      "label": "Becoming vegetarian",
      "description":
          "I will not eat any meat from any animal (including fish).",
      "requires": [
        {
          "id": "no-beef",
          "label": "Not eating beef",
          "description": "I will avoid eating beef (Goodbye stake)."
        },
      ],
    },
  ],
  'category': 'food',
  'date_end': '2030-01-01',
  'date_limit_join': '2030-01-01',
  'date_start': '2020-01-01',
  'images': cImagesJson,
  'location': 'Amsterdam',
  'participant_count': 0,
  'top_participants': [],
};
