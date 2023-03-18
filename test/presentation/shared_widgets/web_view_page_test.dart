import 'package:collaction_app/presentation/shared_widgets/web_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webview_flutter/webview_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

import '../../test_helper.dart';

part 'web_view.mocks.dart';

void main() {
  final testUrl = 'https://collaction.org';

  setUp(() {
    WebViewPlatform.instance = FakeWebViewPlatform(testUrl);
  });

  group('WebViewPage tests:', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: WebViewPage(
          url: testUrl,
          title: 'title',
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(WebViewPage), findsOneWidget);
      expect(find.text('title'), findsOneWidget);
    });

    testWidgets('links the correct webpage', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: WebViewPage(
          url: testUrl,
          title: 'title',
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(WebViewWidget), findsOneWidget);

      final webView =
          tester.firstWidget<WebViewWidget>(find.byType(WebViewWidget));
      final url = await webView.platform.params.controller.currentUrl();

      expect(
        url,
        equals(testUrl),
      );
    });
  });
}
