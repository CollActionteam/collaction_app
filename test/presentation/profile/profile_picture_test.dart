import 'dart:io';

import 'package:collaction_app/presentation/profile/widget/profile_picture.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('ProfilePicture tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(
          tester: tester,
          widget: ProfilePicture(
            maxRadius: 40,
          ));
      await tester.pumpAndSettle();

      expect(find.byType(ProfilePicture), findsOneWidget);
    });

    testWidgets('with profileImage', (WidgetTester tester) async {
      await buildAndPump(
          tester: tester,
          widget: ProfilePicture(
            profileImage: 'profileImage',
            maxRadius: 40,
          ));
      await tester.pumpAndSettle();

      expect(find.byType(ProfilePicture), findsOneWidget);
    });

    testWidgets('with image', (WidgetTester tester) async {
      await buildAndPump(
          tester: tester,
          widget: ProfilePicture(
            image: File('file'),
            maxRadius: 40,
          ));
      await tester.pumpAndSettle();

      expect(find.byType(ProfilePicture), findsOneWidget);
    });
  });
}
