import 'dart:async';

import 'package:collaction_app/domain/user/user.dart';
import 'package:collaction_app/presentation/crowdaction/crowdaction_details/comments/comment_form.dart';
import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
    Future<String> getIdToken([bool forceRefresh = false]) async {
      return "stuff";
    }

    // Username
    testWidgets('Display current username in form header',
        (WidgetTester tester) async {
      const name = "John Doe";

      final StreamController<User> controller = StreamController<User>()
        ..add(User(id: "12345", displayName: name, getIdToken: getIdToken));

      TestUtilities.mockUser(controller.stream);

      await _pumpTestWidget(tester);

      expect(find.text(name), findsOneWidget);
    });

    testWidgets('Current username should have color of PRIMARY/400',
        (WidgetTester tester) async {
      const name = "John Doe";

      final StreamController<User> controller = StreamController<User>()
        ..add(User(id: "12345", displayName: name, getIdToken: getIdToken));

      TestUtilities.mockUser(controller.stream);

      await _pumpTestWidget(tester);

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

      final nameTextWidget = tester.firstWidget(find.text(name)) as Text;
      expect(nameTextWidget.style?.fontWeight, 300);
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

      await _pumpTestWidget(tester);

      final imageWidget = tester.firstWidget(
        find.descendant(
          of: find.byType(CircleAvatar),
          matching: find.byType(NetworkImage),
        ),
      ) as NetworkImage;

      expect(imageWidget.url, photoURL);
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
      await _pumpTestWidget(tester);

      final commentTextField =
          tester.firstWidget(find.byType(TextField)) as TextField;
      expect(commentTextField.decoration?.labelText, "Write a comment");
    });

    testWidgets(
        'Comment text field allows for multiline input with a maximum of 5 lines',
        (WidgetTester tester) async {
      await _pumpTestWidget(tester);

      final commentTextField =
          tester.firstWidget(find.byType(TextField)) as TextField;
      expect(commentTextField.minLines, 1);
      // TODO - Affirm how to set maximum height & leave lines as infinite
      expect(commentTextField.maxLines, 5);
    });

    testWidgets('Comment text field should have border radius of 20',
        (WidgetTester tester) async {
      await _pumpTestWidget(tester);

      final commentTextField =
          tester.firstWidget(find.byType(TextField)) as TextField;
      final borderRadius =
          (commentTextField.decoration?.border as OutlineInputBorder?)
              ?.borderRadius;
      expect(borderRadius?.topLeft, 20);
      expect(borderRadius?.topRight, 20);
      expect(borderRadius?.bottomLeft, 20);
      expect(borderRadius?.bottomRight, 20);
    });

    testWidgets('Comment text field should have background of PRIMARY/0',
        (WidgetTester tester) async {
      await _pumpTestWidget(tester);

      final commentTextField =
          tester.firstWidget(find.byType(TextField)) as TextField;
      expect(commentTextField.decoration?.fillColor, kPrimaryColor0);
    });

    testWidgets('Comment text field should have text color of PRIMARY/300',
        (WidgetTester tester) async {
      await _pumpTestWidget(tester);

      final commentTextField =
          tester.firstWidget(find.byType(TextField)) as TextField;
      expect(commentTextField.style?.color, kPrimaryColor300);
    });

    testWidgets('Comment text field should have font weight of 300',
        (WidgetTester tester) async {
      await _pumpTestWidget(tester);

      final commentTextField =
          tester.firstWidget(find.byType(TextField)) as TextField;
      expect(commentTextField.style?.fontWeight, 300);
    });

    // Publish comment button
    testWidgets(
        '"Publish comment" button is disabled when comment text field is empty',
        (WidgetTester tester) async {
      await _pumpTestWidget(tester);

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
      await _pumpTestWidget(tester);

      expect(find.byType(TextField), findsOneWidget);
      await tester.pump();
      await tester.enterText(find.byType(TextField), "Hi");

      await tester.pump(const Duration(milliseconds: 400));

      final publishCommentButton =
          tester.firstWidget(find.byType(ElevatedButton)) as ElevatedButton;
      expect(publishCommentButton.enabled, false);
    });

    // TODO - Write tests for pill button
  });
}
