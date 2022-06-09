import 'package:collaction_app/application/crowdaction/spotlight/spotlight_bloc.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/domain/crowdaction/i_crowdaction_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockCrowdactionRepo extends Mock implements ICrowdActionRepository {}

final tCrowdactionRepo = MockCrowdactionRepo();
final tCrowdactionRepo2 = MockCrowdactionRepo();
final tSpotlightBloc = SpotlightBloc(tCrowdactionRepo);
final tCrowdaction = CrowdAction(
  crowdactionID: 'tID',
  title: 'tTitle',
  description: 'tDescription',
  category: 'tCategory',
  location: 'tLocation',
  topParticipants: [TopParticipant(userId: 'tUser', name: 'tName')],
  commitmentOptions: [
    CommitmentOption(
      id: 'no-beef',
      label: 'tLabel',
      description: 'tDescription',
    )
  ],
  dateStart: DateTime(2022, 1, 2),
  dateEnd: DateTime(2022, 1, 31),
  dateLimitJoin: DateTime(2022, 1, 10),
  images: const Images(card: 'tCard', banner: 'tBanner'),
  participantCount: 10,
  passwordJoin: 'testPwd',
);
