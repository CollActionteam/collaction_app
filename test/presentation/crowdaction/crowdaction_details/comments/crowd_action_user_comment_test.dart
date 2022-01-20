import 'dart:async';

import 'package:collaction_app/domain/crowdaction/crowdaction_comment.dart';
import 'package:collaction_app/domain/profile/profile.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:collaction_app/infrastructure/crowdaction/crowdaction_comment_dto.dart';
import 'package:collaction_app/presentation/crowdaction/crowdaction_details/comments/crowdaction_comment.dart';
import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:collaction_app/presentation/utils/time.ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_utilities.dart';

void main() {
  group('CrowdAction Comment', () {
    Future<void> _pumpTestWidget(
      WidgetTester tester,
      CrowdActionComment comment,
    ) =>
        tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CrowdActionUserComment(
                comment: comment,
              ),
            ),
          ),
        );

    // ignore: avoid_positional_boolean_parameters
    Future<String> getIdToken([bool forceRefresh = false]) async => "stuff";

    const _userId = "12345";
    const _userName = "John Doe";

    final _defaultUser = User(
      id: _userId,
      displayName: _userName,
      getIdToken: getIdToken,
    );

    void _setUpUser({required User user}) {
      final StreamController<User> controller = StreamController<User>()
        ..add(
          user,
        );

      TestUtilities.mockUser(controller.stream);
    }

    Future<void> _setUpUserAndComment(
      WidgetTester tester,
      Profile profile,
      CrowdActionComment comment,
      User user,
    ) async {
      TestUtilities.mockProfileApi(profile);

      _setUpUser(user: user);
      await _pumpTestWidget(tester, comment);

      await tester.pumpAndSettle();
    }

    // Time
    testWidgets('Display customized comment time e.g 3 days ago',
        (WidgetTester tester) async {
      // Profile
      final profile = Profile(
        phone: "XXXXXXXXXXXX",
        userid: _defaultUser.id,
        displayname: "John Doe",
      );

      const difference = 3;
      final time = DateTime.now().subtract(const Duration(days: difference));

      final CrowdActionComment comment = CrowdActionCommentDto.fromJson({
        "crowdactionID": "Stuff",
        "message": "An interesting message",
        "senderId": profile.userid,
        "createdAt": time.toString()
      }).toDomain();

      await _setUpUserAndComment(tester, profile, comment, _defaultUser);

      // Get username
      expect(find.text("${time.toCommentTime()} ago"), findsOneWidget);
    });

    // Delete Button
    testWidgets('Display delete button if user is owner of comment',
        (WidgetTester tester) async {
      final profile = Profile(
        phone: "XXXXXXXXXXXX",
        userid: _defaultUser.id,
        displayname: "John Doe",
      );

      final CrowdActionComment comment = CrowdActionCommentDto.fromJson({
        "crowdactionID": "Stuff",
        "message": "An interesting message",
        "senderId": profile.userid,
        "createdAt": DateTime.now().toString()
      }).toDomain();

      await _setUpUserAndComment(tester, profile, comment, _defaultUser);

      expect(find.text("Delete"), findsOneWidget);
    });

    testWidgets('Hide delete button if user is not owner of comment',
        (WidgetTester tester) async {
      // Profile
      const profile = Profile(
        phone: "XXXXXXXXXXXX",
        userid: "sample",
        displayname: "John Doe",
      );

      final CrowdActionComment comment = CrowdActionCommentDto.fromJson({
        "crowdactionID": "Stuff",
        "message": "An interesting message",
        "senderId": profile.userid,
        "createdAt": DateTime.now().toString()
      }).toDomain();

      await _setUpUserAndComment(tester, profile, comment, _defaultUser);

      expect(find.text("Delete"), findsNothing);
    });

    // Username
    testWidgets('Display sender username in comment header',
        (WidgetTester tester) async {
      const name = "Jet Lee";
      // Profile
      const profile = Profile(
        phone: "XXXXXXXXXXXX",
        userid: "sample",
        displayname: name,
      );

      final CrowdActionComment comment = CrowdActionCommentDto.fromJson({
        "crowdactionID": "Stuff",
        "message": "An interesting message",
        "senderId": profile.userid,
        "createdAt": DateTime.now().toString()
      }).toDomain();

      await _setUpUserAndComment(tester, profile, comment, _defaultUser);

      // Get username
      expect(find.text(name), findsOneWidget);
    });

    testWidgets('Sender username should have color of PRIMARY/400',
        (WidgetTester tester) async {
      const name = "Jet Lee";
      // Profile
      const profile = Profile(
        phone: "XXXXXXXXXXXX",
        userid: "sample",
        displayname: name,
      );

      final CrowdActionComment comment = CrowdActionCommentDto.fromJson({
        "crowdactionID": "Stuff",
        "message": "An interesting message",
        "senderId": profile.userid,
        "createdAt": DateTime.now().toString()
      }).toDomain();

      await _setUpUserAndComment(tester, profile, comment, _defaultUser);

      final nameTextWidget = tester.firstWidget(find.text(name)) as Text;
      expect(nameTextWidget.style?.color, kPrimaryColor400);
    });

    // Message
    testWidgets('Comment text should have border radius of 20',
        (WidgetTester tester) async {
      // Profile
      const profile = Profile(
        phone: "XXXXXXXXXXXX",
        userid: "sample",
        displayname: "Jet Lee",
      );

      final CrowdActionComment comment = CrowdActionCommentDto.fromJson({
        "crowdactionID": "Stuff",
        "message": "An interesting message",
        "senderId": profile.userid,
        "createdAt": DateTime.now().toString()
      }).toDomain();

      await _setUpUserAndComment(tester, profile, comment, _defaultUser);

      final commentTextContainer = tester.firstWidget(
        find.ancestor(
          of: find.text(comment.message),
          matching: find.byType(Container),
        ),
      ) as Container;
      final borderRadius =
          (commentTextContainer.decoration as BoxDecoration?)?.borderRadius;

      expect(borderRadius, const BorderRadius.all(Radius.circular(20)));
    });

    testWidgets('Comment text should have background of PRIMARY/0',
        (WidgetTester tester) async {
      // Profile
      const profile = Profile(
        phone: "XXXXXXXXXXXX",
        userid: "sample",
        displayname: "Jet Lee",
      );

      final CrowdActionComment comment = CrowdActionCommentDto.fromJson({
        "crowdactionID": "Stuff",
        "message": "An interesting message",
        "senderId": profile.userid,
        "createdAt": DateTime.now().toString()
      }).toDomain();

      await _setUpUserAndComment(tester, profile, comment, _defaultUser);

      final commentTextContainer = tester.firstWidget(
        find.ancestor(
          of: find.text(comment.message),
          matching: find.byType(Container),
        ),
      ) as Container;

      final backgroundColor =
          (commentTextContainer.decoration as BoxDecoration?)?.color;

      expect(backgroundColor, kAlmostTransparent);
    });

    testWidgets('Comment text should have text color of PRIMARY/300',
        (WidgetTester tester) async {
      // Profile
      const profile = Profile(
        phone: "XXXXXXXXXXXX",
        userid: "sample",
        displayname: "Jet Lee",
      );

      final CrowdActionComment comment = CrowdActionCommentDto.fromJson({
        "crowdactionID": "Stuff",
        "message": "An interesting message",
        "senderId": profile.userid,
        "createdAt": DateTime.now().toString()
      }).toDomain();

      await _setUpUserAndComment(tester, profile, comment, _defaultUser);

      final commentTextField =
          tester.firstWidget(find.text(comment.message)) as Text;
      expect(commentTextField.style?.color, kPrimaryColor300);
    });

    testWidgets('Comment text should have font weight of 300',
        (WidgetTester tester) async {
      // Profile
      const profile = Profile(
        phone: "XXXXXXXXXXXX",
        userid: "sample",
        displayname: "Jet Lee",
      );

      final CrowdActionComment comment = CrowdActionCommentDto.fromJson({
        "crowdactionID": "Stuff",
        "message": "An interesting message",
        "senderId": profile.userid,
        "createdAt": DateTime.now().toString()
      }).toDomain();

      await _setUpUserAndComment(tester, profile, comment, _defaultUser);

      final commentTextField =
          tester.firstWidget(find.text(comment.message)) as Text;
      expect(commentTextField.style?.fontWeight, FontWeight.w300);
    });
  });
}
