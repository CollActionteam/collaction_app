import 'package:collaction_app/domain/participation/participation.dart';

import 'crowdaction.fixtures.dart';
import 'user.fixtures.dart';

/// Reusable participation fixtures
final testParticipation = Participation(
  id: 'id',
  crowdActionId: testCrowdAction.id,
  fullName: testProfile.fullName,
  avatar: testProfile.avatar,
  userId: testUser.id,
  commitmentOptions: [],
  joinDate: DateTime.now(),
  dailyCheckIns: 2,
);
