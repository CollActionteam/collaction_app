import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/infrastructure/crowdaction/crowdaction_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  // Mocked CrowdActionRepository
  final client = MockClient();
  final CrowdActionRepository crowdActionRepository =
      CrowdActionRepository(client);

  group('CrowdAction Getter Bloc:', () {
    // Setup Mocked Repository
    when(() => crowdActionRepository.getCrowdActions())
        .thenAnswer((_) async => crowdactions);

    // TODO: Implement tests for CrowdAction Getter BLoC
    // final crowdActionGetterBloc = CrowdActionGetterBloc(crowdActionRepository);
  });
}

// Mocked Data
final List<CrowdAction> crowdactions = [
  CrowdAction(
      name: 'Dansen bij Pakhuis de Règâh op 9 feb',
      description:
          'Misschien wel het belangrijkste collectieve actie probleem dat er is: dansen op een feestje ;). Het is voor iedereen leuker als iedereen gewoon lekker meedanst, maar je hebt nou eenmaal een kritieke massa nodig om het feestje lekker op gang te krijgen. Als 10 mensen nou toezeggen om lekker te gaan dansen vanavond, dan hebben we die massa wel. Doe je mee?',
      start: DateTime.parse('2018-02-09T00:00:00+00:00'),
      end: DateTime.parse('2018-02-10T23:59:59+00:00')),
  CrowdAction(
      name: 'Earth Hour candlelight dinner voor bedrijven',
      description:
          '24 maart is het weer Earth Hour! Wereldwijd gaat in meer dan 185 landen van 20.30 tot 21.30 op heel veel plekken het licht uit om aandacht te vragen voor de kwetsbare natuur op onze aarde. Van de Eiffeltoren in Parijs tot het Opera House in Sidney, en de Erasmusbrug in Rotterdam tot de Martinitoren in Groningen. Doe ook mee! Breng Earth Hour onder de aandacht bij uw medewerkers en relaties en doe met uw bedrijf mee aan onze actie om met zoveel mogelijk Nederlanders een candlelight dinner te organiseren.',
      start: DateTime.parse('2018-03-08T00:00:00+00:00'),
      end: DateTime.parse('2018-03-24T23:59:59+00:00')),
  CrowdAction(
      name: "It's getting hot in here - Amsterdam edition",
      description:
          "<p>Fast Fashion is one of the biggest polluting industries in the world and - among other things - one of the biggest contributors to climate change. So, it's time to stand up to Fast Fashion and raise awareness for our Slow Fashion Summer. It's time to take off all our clothes because being naked is the most sustainable option - the Slow Fashion summer is 2nd :)</p>",
      start: DateTime.parse('2018-06-11T00:00:00+00:00'),
      end: DateTime.parse('2018-06-16T23:59:59+00:00')),
];
