import 'package:collaction_app/presentation/shared_widgets/web_view_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../test_helper.dart';

void main() {
  group('WebViewPage tests:', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(
          tester: tester,
          widget: WebViewPage(url: 'https://collaction.org', title: 'title'));
      await tester.pumpAndSettle();

      expect(find.byType(WebViewPage), findsOneWidget);
      expect(find.text('title'), findsOneWidget);
    });

    testWidgets('links the correct webpage', (WidgetTester tester) async {
      await buildAndPump(
          tester: tester,
          widget: WebViewPage(url: 'https://collaction.org', title: 'title'));
      await tester.pumpAndSettle();

      expect(find.byType(WebView), findsOneWidget);
      expect(tester.firstWidget<WebView>(find.byType(WebView)).initialUrl,
          equals('https://collaction.org'));
    });
  });
}
