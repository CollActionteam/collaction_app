import 'package:collaction_app/domain/profile/profile.dart';
import 'package:collaction_app/presentation/shared_widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:shimmer/shimmer.dart';

import '../../test_utilities.dart';

void main() {
  group('User Avatar', () {
    Future<void> _pumpTestWidget(WidgetTester tester, String userId) =>
        tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: UserAvatar(userId: userId),
            ),
          ),
        );

    testWidgets('Display NetworkImage avatar for user with profile photo',
        (WidgetTester tester) async {
      const photoURL = "http://sampleimages.com/profile.png";

      const profile = Profile(
        phone: "XXXXXXXXXXXX",
        userid: "sample",
        displayname: "John Doe",
        photoUrl: photoURL,
      );

      TestUtilities.mockProfileApi(profile);

      mockNetworkImagesFor(() async {
        await _pumpTestWidget(tester, profile.userid);

        await tester.pumpAndSettle();

        final imageWidget =
            tester.firstWidget(find.byType(CircleAvatar)) as CircleAvatar;

        expect(imageWidget.backgroundImage is NetworkImage, true);

        final provider = imageWidget.backgroundImage as NetworkImage?;
        expect(provider?.url, photoURL);
      });
    });

    testWidgets(
        'Display Text avatar with first letter of username for user with no profile photo',
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

      final textWidget = tester.firstWidget(
        find.descendant(
          of: find.byType(CircleAvatar),
          matching: find.byType(Text),
        ),
      ) as Text;

      expect(textWidget.data, name[0]);
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
