import 'dart:async';

import 'package:collaction_app/domain/user/user.dart';
import 'package:collaction_app/presentation/crowdaction/crowdaction_details/comments/crowdaction_comment_form.dart';
import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../test_utilities.dart';

void main() {
  group('CrowdAction new comment from', () {
    Future<void> _pumpTestWidget(WidgetTester tester) => tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: CommentForm(),
            ),
          ),
        );

    // ignore: avoid_positional_boolean_parameters
    Future<String> getIdToken([bool forceRefresh = false]) async => "stuff";

    void _setUpUser() {
      final StreamController<User> controller = StreamController<User>()
        ..add(
          User(
            id: "12345",
            displayName: "John Doe",
            getIdToken: getIdToken,
          ),
        );

      TestUtilities.mockUser(controller.stream);
    }

    // Username
    testWidgets('Display current username in form header',
        (WidgetTester tester) async {
      const name = "John Doe";

      final StreamController<User> controller = StreamController<User>()
        ..add(User(id: "12345", displayName: name, getIdToken: getIdToken));

      TestUtilities.mockUser(controller.stream);

      await _pumpTestWidget(tester);

      await tester.pumpAndSettle();

      expect(find.text(name), findsOneWidget);
    });

    testWidgets('Current username should have color of PRIMARY/400',
        (WidgetTester tester) async {
      const name = "John Doe";

      final StreamController<User> controller = StreamController<User>()
        ..add(User(id: "12345", displayName: name, getIdToken: getIdToken));

      TestUtilities.mockUser(controller.stream);

      await _pumpTestWidget(tester);

      await tester.pumpAndSettle();

      final nameTextWidget = tester.firstWidget(find.text(name)) as Text;
      expect(nameTextWidget.style?.color, kPrimaryColor400);
    });

    testWidgets('Current username should have font weight of 300',
        (WidgetTester tester) async {
      const name = "John Doe";

      final StreamController<User> controller = StreamController<User>()
        ..add(User(id: "12345", displayName: name, getIdToken: getIdToken));

      TestUtilities.mockUser(controller.stream);

      await _pumpTestWidget(tester);

      await tester.pumpAndSettle();

      final nameTextWidget = tester.firstWidget(find.text(name)) as Text;
      expect(nameTextWidget.style?.fontWeight, FontWeight.w300);
    });

    // Avatar
    testWidgets('Display NetworkImage avatar for user with profile photo',
        (WidgetTester tester) async {
      const photoURL = "http://sampleimages.com/profile.png";

      final StreamController<User> controller = StreamController<User>()
        ..add(
          User(
            id: "12345",
            displayName: "John Doe",
            getIdToken: getIdToken,
            photoURL: photoURL,
          ),
        );

      TestUtilities.mockUser(controller.stream);

      mockNetworkImagesFor(() async {
        await _pumpTestWidget(tester);

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

      final StreamController<User> controller = StreamController<User>()
        ..add(
          User(
            id: "12345",
            displayName: name,
            getIdToken: getIdToken,
          ),
        );

      TestUtilities.mockUser(controller.stream);

      await _pumpTestWidget(tester);

      await tester.pumpAndSettle();

      final textWidget = tester.firstWidget(
        find.descendant(
          of: find.byType(CircleAvatar),
          matching: find.byType(Text),
        ),
      ) as Text;

      expect(textWidget.data, name[0]);
    });

    // Comment text field
    testWidgets('Comment text field has label "Write a comment"',
        (WidgetTester tester) async {
      _setUpUser();
      await _pumpTestWidget(tester);
      await tester.pumpAndSettle();
      final commentTextField =
          tester.firstWidget(find.byType(TextField)) as TextField;
      expect(commentTextField.decoration?.hintText, "Write a comment");
    });

    testWidgets(
        'Comment text field allows for multiline input with a maximum of 5 lines',
        (WidgetTester tester) async {
      _setUpUser();
      await _pumpTestWidget(tester);
      await tester.pumpAndSettle();
      final commentTextField =
          tester.firstWidget(find.byType(TextField)) as TextField;
      expect(commentTextField.minLines, 1);
      expect(commentTextField.maxLines, 5);
    });

    testWidgets('Comment text field should have border radius of 20',
        (WidgetTester tester) async {
      _setUpUser();
      await _pumpTestWidget(tester);
      await tester.pumpAndSettle();
      final commentTextField =
          tester.firstWidget(find.byType(TextField)) as TextField;
      final borderRadius =
          (commentTextField.decoration?.border as OutlineInputBorder?)
              ?.borderRadius;
      const radius = Radius.circular(20);
      expect(borderRadius?.topLeft, radius);
      expect(borderRadius?.topRight, radius);
      expect(borderRadius?.bottomLeft, radius);
      expect(borderRadius?.bottomRight, radius);
    });

    testWidgets('Comment text field should have background of PRIMARY/0',
        (WidgetTester tester) async {
      _setUpUser();
      await _pumpTestWidget(tester);
      await tester.pumpAndSettle();
      final commentTextField =
          tester.firstWidget(find.byType(TextField)) as TextField;
      expect(commentTextField.decoration?.fillColor, kAlmostTransparent);
    });

    testWidgets('Comment text field should have text color of PRIMARY/300',
        (WidgetTester tester) async {
      _setUpUser();
      await _pumpTestWidget(tester);
      await tester.pumpAndSettle();
      final commentTextField =
          tester.firstWidget(find.byType(TextField)) as TextField;
      expect(commentTextField.style?.color, kPrimaryColor300);
    });

    testWidgets('Comment text field should have font weight of 300',
        (WidgetTester tester) async {
      _setUpUser();
      await _pumpTestWidget(tester);
      await tester.pumpAndSettle();
      final commentTextField =
          tester.firstWidget(find.byType(TextField)) as TextField;
      expect(commentTextField.style?.fontWeight, FontWeight.w300);
    });

    // Publish comment button
    testWidgets('"Publish comment" button has text "Publish comment"',
        (WidgetTester tester) async {
      _setUpUser();
      await _pumpTestWidget(tester);
      await tester.pumpAndSettle();

      final buttonTextWidget = tester.firstWidget(
        find.descendant(
          of: find.byType(ElevatedButton),
          matching: find.byType(Text),
        ),
      ) as Text;
      expect(buttonTextWidget.data, "Publish comment");
    });

    testWidgets(
        '"Publish comment" button is disabled when comment text field is empty',
        (WidgetTester tester) async {
      _setUpUser();
      await _pumpTestWidget(tester);
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsOneWidget);
      await tester.pump();
      await tester.enterText(find.byType(TextField), "");

      await tester.pump(const Duration(milliseconds: 400));

      final publishCommentButton =
          tester.firstWidget(find.byType(ElevatedButton)) as ElevatedButton;
      expect(publishCommentButton.enabled, false);
    });

    testWidgets(
        '"Publish comment" button is enabled when comment text field has content',
        (WidgetTester tester) async {
      _setUpUser();
      await _pumpTestWidget(tester);
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsOneWidget);
      await tester.pump();
      await tester.enterText(find.byType(TextField), "Hi");

      await tester.pump(const Duration(milliseconds: 400));

      final publishCommentButton =
          tester.firstWidget(find.byType(ElevatedButton)) as ElevatedButton;
      expect(publishCommentButton.enabled, true);
    });

    // TODO - Write tests for pill button
  });
}
