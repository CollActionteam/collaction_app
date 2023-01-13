import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/crowdaction/crowdaction_participants/crowdaction_participants_bloc.dart';

class MockCrowdActionParticipantsBloc
    extends MockBloc<CrowdActionParticipantsEvent, CrowdActionParticipantsState>
    implements CrowdActionParticipantsBloc {}
