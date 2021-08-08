import 'package:collaction_app/application/crowdaction_getter/crowdaction_getter_bloc.dart';
import 'package:collaction_app/infrastructure/crowdaction/crowdaction_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  group('CrowdAction Getter Bloc', () {
    CrowdActionGetterBloc? crowdActionGetterBloc;

    // Initialize Bloc, Repository and HTTP Client
    setUp(() {
      crowdActionGetterBloc =
          CrowdActionGetterBloc(CrowdActionRepository(http.Client()));
    });

    // Test state on Bloc creation
    test('Initial State for our Bloc', () {
      crowdActionGetterBloc!.state
          .maybeWhen(initial: () => true, orElse: () => false);
    });

    // Test fetching of ALL crowdactions
    test('Fetch crowdactions', () {
      crowdActionGetterBloc!.add(const CrowdActionGetterEvent.getMore(null));

      crowdActionGetterBloc!.state
          .maybeWhen(orElse: () => false, fetched: (result) => true);
    });

    // Test fetching of fixed amount of crowdactions
    test('Fetch fixed amount of crowdactions', () {
      const amountToFetch = 3;
      crowdActionGetterBloc!
          .add(const CrowdActionGetterEvent.getMore(amountToFetch));

      crowdActionGetterBloc!.state.maybeWhen(
          orElse: () => false,
          fetched: (result) => result.length == amountToFetch);
    });
  });
}
