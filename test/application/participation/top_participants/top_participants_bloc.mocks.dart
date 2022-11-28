import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/participation/top_participants/top_participants_bloc.dart';

class MockTopParticipantsBloc
    extends MockBloc<TopParticipantsEvent, TopParticipantsState>
    implements TopParticipantsBloc {}
