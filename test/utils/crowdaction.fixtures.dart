import 'package:collaction_app/domain/crowdaction/crowdaction.dart';

/// Reusable crowdaction fixtures
final testCrowdAction = CrowdAction(
  id: 'id',
  type: 'type',
  title: 'title',
  description: 'description',
  category: 'category',
  location: const Location(code: 'code', name: 'name'),
  commitmentOptions: [],
  images: const Images(banner: 'banner.png', card: 'card.png'),
  participantCount: 1,
  status: Status.started,
  joinStatus: JoinStatus.open,
  endAt: DateTime.now(),
);
