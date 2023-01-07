import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/crowdaction/crowdaction_details/crowdaction_details_bloc.dart';

class MockCrowdActionDetailsBloc
    extends MockBloc<CrowdActionDetailsEvent, CrowdActionDetailsState>
    implements CrowdActionDetailsBloc {}
