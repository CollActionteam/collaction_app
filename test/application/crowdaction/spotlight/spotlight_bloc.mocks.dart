import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/crowdaction/spotlight/spotlight_bloc.dart';

class MockSpotlightBloc extends MockBloc<SpotlightEvent, SpotlightState>
    implements SpotlightBloc {}
