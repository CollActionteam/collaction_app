import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/participation/participation_bloc.dart';

class MockParticipationBloc
    extends MockBloc<ParticipationEvent, ParticipationState>
    implements ParticipationBloc {}
