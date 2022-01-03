import 'package:collaction_app/presentation/shared_widgets/custom_app_bars/scrollable_app_bar.dart';
import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Tests for title parameter',
    () {
      testWidgets(
        'The value of parameter title should be used as title, if provided',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                appBar: ScrollableAppBar(
                  pageScrollController: ScrollController(),
                  title: 'Home',
                ),
              ),
            ),
          );

          expect(find.text('Home'), findsOneWidget);
        },
      );
      testWidgets(
        'An empty string should be used as title if title is not provided',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                appBar: ScrollableAppBar(
                  pageScrollController: ScrollController(),
                ),
              ),
            ),
          );
          expect(find.text(''), findsOneWidget);
        },
      );
    },
  );

  group(
    'Tests for backgroundColor parameter',
    () {
      testWidgets(
        'The value of parameter backgroundColor should be used as backgroundColor, if provided',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                appBar: ScrollableAppBar(
                  backgroundColor: Colors.red,
                  pageScrollController: ScrollController(),
                ),
              ),
            ),
          );

          expect(
            find.byWidgetPredicate(
              (widget) =>
                  widget is AppBar && widget.backgroundColor == Colors.red,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'kSecondaryColor should be used as backgroundColor if backgroundColor is not provided',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                appBar: ScrollableAppBar(
                  pageScrollController: ScrollController(),
                ),
              ),
            ),
          );
          expect(
            find.byWidgetPredicate(
              (widget) =>
                  widget is AppBar && widget.backgroundColor == kSecondaryColor,
            ),
            findsOneWidget,
          );
        },
      );
    },
  );

  group(
    'Tests for centerTitle parameter',
    () {
      testWidgets(
        'The value of parameter centerTitle should be used to center title, if provided',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                appBar: ScrollableAppBar(
                  pageScrollController: ScrollController(),
                  centerTitle: false,
                ),
              ),
            ),
          );

          expect(
            find.byWidgetPredicate(
              (widget) => widget is AppBar && widget.centerTitle == false,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'The boolean value true should be used as the default value of property centerTitle',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                appBar: ScrollableAppBar(
                  pageScrollController: ScrollController(),
                ),
              ),
            ),
          );

          expect(
            find.byWidgetPredicate(
              (widget) => widget is AppBar && widget.centerTitle == true,
            ),
            findsOneWidget,
          );
        },
      );
    },
  );

  group(
    'Tests for elevation',
    () {
      late ScrollController scrollController;

      setUp(
        () {
          scrollController = ScrollController();
        },
      );

      tearDown(
        () {
          scrollController.dispose();
        },
      );

      testWidgets(
        'The value of property elevation should be used to elevate the AppBar independent of the scrolling, if provided',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                appBar: ScrollableAppBar(
                  pageScrollController: scrollController,
                  elevation: 1.0,
                ),
                body: ListView.builder(
                  controller: scrollController,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(index.toString()),
                  ),
                  itemCount: 20,
                ),
              ),
            ),
          );

          expect(
            find.byWidgetPredicate(
              (widget) => widget is AppBar && widget.elevation == 1.0,
            ),
            findsOneWidget,
          );

          scrollController.jumpTo(scrollController.position.maxScrollExtent);

          await tester.pump();

          expect(
            find.byWidgetPredicate(
              (widget) => widget is AppBar && widget.elevation == 1.0,
            ),
            findsOneWidget,
          );

          scrollController
              .jumpTo(scrollController.position.maxScrollExtent / 2);

          await tester.pump();

          expect(
            find.byWidgetPredicate(
              (widget) => widget is AppBar && widget.elevation == 1.0,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'The value of property maxElevation should be used to elevate the AppBar if we are scrolling or if we are in the middle of a scroll and if the elevation property is null',
        (WidgetTester tester) async {
          final ScrollableAppBar scrollableAppBar = ScrollableAppBar(
            pageScrollController: scrollController,
          );

          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                appBar: scrollableAppBar,
                body: ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      index.toString(),
                    ),
                  ),
                  itemCount: 20,
                  controller: scrollController,
                ),
              ),
            ),
          );

          scrollController
              .jumpTo(scrollController.position.maxScrollExtent / 2);

          await tester.pump();

          expect(
            find.byWidgetPredicate(
              (widget) => widget is AppBar && widget.elevation == 2.0,
            ),
            findsOneWidget,
          );

          scrollController.jumpTo(scrollController.position.maxScrollExtent);

          await tester.pump();

          expect(
            find.byWidgetPredicate(
              (widget) => widget is AppBar && widget.elevation == 2.0,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'The value of minElevation should be used to elevate the AppBar if we are at the top of the scroll and if the elevation property is null',
        (WidgetTester tester) async {
          final ScrollableAppBar scrollableAppBar = ScrollableAppBar(
            pageScrollController: scrollController,
          );

          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                appBar: scrollableAppBar,
                body: ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      index.toString(),
                    ),
                  ),
                  itemCount: 20,
                  controller: scrollController,
                ),
              ),
            ),
          );

          expect(
            find.byWidgetPredicate(
              (widget) => widget is AppBar && widget.elevation == 0.0,
            ),
            findsOneWidget,
          );

          scrollController
              .jumpTo(scrollController.position.maxScrollExtent / 2);

          await tester.pump();

          expect(
            find.byWidgetPredicate(
              (widget) => widget is AppBar && widget.elevation != 0.0,
            ),
            findsOneWidget,
          );

          scrollController.jumpTo(scrollController.position.minScrollExtent);

          await tester.pump();

          expect(
            find.byWidgetPredicate(
              (widget) => widget is AppBar && widget.elevation == 0.0,
            ),
            findsOneWidget,
          );
        },
      );
    },
  );

  group(
    'Tests for titleTextStyle parameter',
    () {
      testWidgets(
        'ScrollableAppBar should use the value of parameter titleTextStyle to style the title, if provided',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                appBar: ScrollableAppBar(
                  pageScrollController: ScrollController(),
                  title: 'Home',
                  titleTextStyle: const TextStyle(
                    fontSize: 10.0,
                    color: Colors.yellow,
                  ),
                ),
              ),
            ),
          );

          expect(
            find.byWidgetPredicate(
              (widget) =>
                  widget is AppBar &&
                  widget.titleTextStyle ==
                      const TextStyle(
                        fontSize: 10.0,
                        color: Colors.yellow,
                      ),
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'ScrollableAppBar should use headline6 colored with kPrimaryColor as default value of property titleTextStyle',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                appBar: ScrollableAppBar(
                  pageScrollController: ScrollController(),
                  title: 'Home',
                ),
              ),
            ),
          );

          find.descendant(
            of: find.byType(ScrollableAppBar),
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is AppBar &&
                  widget.titleTextStyle?.color == kPrimaryColor,
            ),
          );
        },
      );
    },
  );
}
