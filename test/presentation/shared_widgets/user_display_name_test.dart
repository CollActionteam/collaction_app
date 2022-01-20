import 'package:collaction_app/domain/profile/profile.dart';
import 'package:collaction_app/presentation/shared_widgets/user_display_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer/shimmer.dart';

import '../../test_utilities.dart';

void main() {
  group('User Display Name', () {
    Future<void> _pumpTestWidget(WidgetTester tester, String userId) =>
        tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: UserDisplayName(userId: userId),
            ),
          ),
        );

    testWidgets('Show display name from user profile',
        (WidgetTester tester) async {
      const name = "John Doe";

      const profile = Profile(
        phone: "XXXXXXXXXXXX",
        userid: "sample",
        displayname: name,
      );

      TestUtilities.mockProfileApi(profile);

      await _pumpTestWidget(tester, profile.userid);

      await tester.pumpAndSettle();

      expect(find.text(name), findsOneWidget);
    });

    testWidgets('Display Shimmer if error occurs getting user profile',
        (WidgetTester tester) async {
      const profile = Profile(
        phone: "XXXXXXXXXXXX",
        userid: "sample",
        displayname: "John Doe",
      );

      TestUtilities.mockProfileApi(profile, error: true);

      await _pumpTestWidget(tester, profile.userid);

      await tester.pump();

      expect(find.byType(Shimmer), findsOneWidget);
    });
  });
}
