import 'package:collaction_app/domain/core/location.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/infrastructure/core/location_dto.dart';
import 'package:collaction_app/infrastructure/crowdaction/crowdaction_dto.dart';

final crowdActionDto = CrowdActionDto(
  id: 'crowdaction-id',
  title: 'crowdaction-title',
  description: 'crowdaction-description',
  category: 'crowdaction-category',
  location: LocationDto(code: 'NL', name: 'Netherlands'),
  commitmentOptions: [],
  images: ImagesDto(card: 'crowdaction-card', banner: 'crowdaction-banner'),
  participantCount: 0,
  status: Status.waiting,
  joinStatus: JoinStatus.open,
  endAt: '2024-01-01T00:00:00.000+00:00',
  password: 'crowdaction-password',
  subcategory: 'crowdaction-subcategory',
  type: 'crowdaction-type',
);

final crowdActionDomain = CrowdAction(
  id: 'crowdaction-id',
  type: 'crowdaction-type',
  title: 'crowdaction-title',
  description: 'crowdaction-description',
  category: 'crowdaction-category',
  subcategory: 'crowdaction-subcategory',
  location: const Location(code: 'NL', name: 'Netherlands'),
  password: 'crowdaction-password',
  participantCount: 0,
  images: const Images(card: 'crowdaction-card', banner: 'crowdaction-banner'),
  status: Status.waiting,
  joinStatus: JoinStatus.open,
  endAt: DateTime.parse("2024-01-01T00:00:00.000+00:00"),
  commitmentOptions: [],
);

final crowdActionJson = {
  "id": "crowdaction-id",
  "type": "crowdaction-type",
  "title": "crowdaction-title",
  "description": "crowdaction-description",
  "category": "crowdaction-category",
  "subcategory": "crowdaction-subcategory",
  "location": {"code": "NL", "name": "Netherlands"},
  "password": "crowdaction-password",
  "participantCount": 0,
  "images": {"card": "crowdaction-card", "banner": "crowdaction-banner"},
  "status": "WAITING",
  "joinStatus": "OPEN",
  "endAt": "2024-01-01T00:00:00.000+00:00",
  "commitmentOptions": [],
};
