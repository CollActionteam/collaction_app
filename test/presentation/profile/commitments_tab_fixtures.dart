import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/domain/user/user.dart';

final user = User(
  id: 'id',
  getIdToken: ([forceRefresh = false]) => Future.value(),
);

final crowdAction = CrowdAction(
  id: 'id',
  type: 'type',
  title: 'title',
  description: 'description',
  category: 'category',
  location: Location(code: 'NL', name: 'The Netherlands'),
  commitmentOptions: [
    CommitmentOption(
      id: 'id',
      type: 'type',
      label: 'label',
      points: 10,
      blocks: [],
    ),
  ],
  images: Images(card: 'card', banner: 'banner'),
  participantCount: 0,
  status: Status.started,
  joinStatus: JoinStatus.open,
  endAt: DateTime.now().add(const Duration(days: 10)),
);
