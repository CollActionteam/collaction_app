import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/settings/build_information/build_information_bloc.dart';

class MockBuildInformationBloc
    extends MockBloc<BuildInformationEvent, BuildInformationState>
    implements BuildInformationBloc {}
