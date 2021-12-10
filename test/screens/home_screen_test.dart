// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:collaction_app/domain/user/user.dart';
import 'package:collaction_app/infrastructure/core/injection.dart';
import 'package:collaction_app/presentation/core/app_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../test_utilities.dart';

void main() {
  setUp(() async {
    configureInjection();
    TestUtilities.mockUser(Stream.value(User.anonymous));
  });
  testWidgets('Home Page and Transitions', (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(AppWidget());
      await tester.pumpAndSettle();

      // Get the current month
      final date = DateTime.parse(DateTime.now().toString());
      final month = DateFormat.MMMM().format(date);

      // Verify that header widget is shown
      expect(find.text("$month's CrowdActions"), findsOneWidget);

      // Verify that share widget is shown
      expect(
          find.text('Share CollAction with\n your friends!'), findsOneWidget);
    });
  });
}
