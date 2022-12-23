import 'package:collaction_app/presentation/crowdaction/crowdaction_details/widgets/crowdaction_details_banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helper.dart';
import '../../../test_utilities.dart';

void main() {
  setUpAll(() {
    dotenv.testLoad(fileInput: tDotEnv);
  });

  group('CrowdActionDetailsBanner tests:', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [CrowdActionDetailsBanner(crowdAction: tCrowdaction)];
          },
          body: SizedBox(),
        ),
      );
      await tester.pump();

      expect(find.byType(CrowdActionDetailsBanner), findsOneWidget);
      expect(
        tester
            .firstWidget<CrowdActionDetailsBanner>(
                find.byType(CrowdActionDetailsBanner))
            .crowdAction,
        equals(tCrowdaction),
      );
    });
  });
}
