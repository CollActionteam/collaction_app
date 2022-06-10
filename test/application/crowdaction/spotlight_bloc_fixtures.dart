import 'package:collaction_app/application/crowdaction/spotlight/spotlight_bloc.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import '../../test_utilities.dart';

final tCrowdactionRepo = MockCrowdActionRepository();
final tCrowdactionRepo2 = MockCrowdActionRepository();
final tSpotlightBloc = SpotlightBloc(tCrowdactionRepo);
