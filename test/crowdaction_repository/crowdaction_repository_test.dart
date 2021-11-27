import 'package:collaction_app/api/queries/crowdaction_queries.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/infrastructure/crowdaction/crowdaction_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('CrowdAction Repository Tests:', () {
    final client = MockClient();
    final CrowdActionRepository crowdActionRepository =
        CrowdActionRepository(client);

    const query = queryGetCrowdActions;

    when(
      () => client.get(
        Uri.parse('https://api.collaction.org/graphql?query=$query'),
        headers: {'Content-Type': 'application/json'},
      ),
    ).thenAnswer((_) async => http.Response(crowdactionsString, 200));

    test('Fetch CrowdActions', () async {
      final _ca = await crowdActionRepository.getCrowdActions();
      expect(_ca, isA<List<CrowdAction>>());
      expect(_ca, hasLength(3));
    });

    const singleCrowdactionQuery =
        "{ crowdactions(take: 1) {name description start end } }";
    when(
      () => client.get(
        Uri.parse(
            'https://api.collaction.org/graphql?query=$singleCrowdactionQuery'),
        headers: {'Content-Type': 'application/json'},
      ),
    ).thenAnswer((_) async => http.Response(singleCrowdactionsString, 200));

    test('Fetch a single CrowdAction', () async {
      expect(
        await crowdActionRepository.getCrowdActions(amount: 1),
        hasLength(1),
      );
    });

    const none = "{ crowdactions(take: 4) {name description start end } }";
    when(
      () => client.get(
        Uri.parse('https://api.collaction.org/graphql?query=$none'),
        headers: {'Content-Type': 'application/json'},
      ),
    ).thenAnswer(
        (_) async => http.Response('{"data":{"crowdactions":[{}]}}', 200));

    test('Fetch Empty List of CrowdActions', () async {
      expect(
        await crowdActionRepository.getCrowdActions(amount: 4),
        hasLength(0),
      );
    });
  });
}

const crowdactionsString =
    '{"data":{"crowdactions":[{"name":"Dansen bij Pakhuis de Règâh op 9 feb","description":"Misschien wel het belangrijkste collectieve actie probleem dat er is: dansen op een feestje ;). Het is voor iedereen leuker als iedereen gewoon lekker meedanst, maar je hebt nou eenmaal een kritieke massa nodig om het feestje lekker op gang te krijgen. Als 10 mensen nou toezeggen om lekker te gaan dansen vanavond, dan hebben we die massa wel. Doe je mee?","start":"2018-02-09T00:00:00+00:00","end":"2018-02-10T23:59:59+00:00","numParticipants":23},{"name":"Earth Hour candlelight dinner voor bedrijven","description":"24 maart is het weer Earth Hour! Wereldwijd gaat in meer dan 185 landen van 20.30 tot 21.30 op heel veel plekken het licht uit om aandacht te vragen voor de kwetsbare natuur op onze aarde. Van de Eiffeltoren in Parijs tot het Opera House in Sidney, en de Erasmusbrug in Rotterdam tot de Martinitoren in Groningen. Doe ook mee! Breng Earth Hour onder de aandacht bij uw medewerkers en relaties en doe met uw bedrijf mee aan onze actie om met zoveel mogelijk Nederlanders een candlelight dinner te organiseren.\\n\\n","start":"2018-03-08T00:00:00+00:00","end":"2018-03-24T23:59:59+00:00","numParticipants":23},{"name":"It\'s getting hot in here - Amsterdam edition","description":"<p>Fast Fashion is one of the biggest polluting industries in the world and - among other things - one of the biggest contributors to climate change. So, it\'s time to stand up to Fast Fashion and raise awareness for our Slow Fashion Summer. It\'s time to take off all our clothes because being naked is the most sustainable option - the Slow Fashion summer is 2nd :)</p>","start":"2018-06-11T00:00:00+00:00","end":"2018-06-16T23:59:59+00:00","numParticipants":23}]}}';

const singleCrowdactionsString =
    '{"data":{"crowdactions":[{"name":"Dansen bij Pakhuis de Règâh op 9 feb","description":"Misschien wel het belangrijkste collectieve actie probleem dat er is: dansen op een feestje ;). Het is voor iedereen leuker als iedereen gewoon lekker meedanst, maar je hebt nou eenmaal een kritieke massa nodig om het feestje lekker op gang te krijgen. Als 10 mensen nou toezeggen om lekker te gaan dansen vanavond, dan hebben we die massa wel. Doe je mee?","start":"2018-02-09T00:00:00+00:00","end":"2018-02-10T23:59:59+00:00","numParticipants":23}]}}';
