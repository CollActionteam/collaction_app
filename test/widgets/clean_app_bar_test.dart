import 'package:collaction_app/core/core.dart';
import 'package:collaction_app/presentation/shared_widgets/custom_app_bars/clean_app_bar.dart';
import 'package:collaction_app/presentation/themes/themes.dart';
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
              theme: lightTheme(),
              home: Scaffold(
                appBar: CleanAppBar(
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
              theme: lightTheme(),
              home: Scaffold(
                appBar: CleanAppBar(),
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
              theme: lightTheme(),
              home: Scaffold(
                appBar: CleanAppBar(
                  backgroundColor: Colors.red,
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
          late BuildContext ctx;

          await tester.pumpWidget(
            MaterialApp(
              theme: lightTheme(),
              home: Builder(builder: (context) {
                ctx = context;
                return Scaffold(
                  appBar: CleanAppBar(),
                );
              }),
            ),
          );

          expect(
            find.byWidgetPredicate(
              (widget) =>
                  widget is AppBar &&
                  widget.backgroundColor == ctx.colors.secondaryColor,
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
        'The value of parameter centerTitle should be used to center the title, if provided',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              theme: lightTheme(),
              home: Scaffold(
                appBar: CleanAppBar(
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
        'The boolean value true should be the default value of property centerTitle',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              theme: lightTheme(),
              home: Scaffold(
                appBar: CleanAppBar(),
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
    'Tests for elevation parameter',
    () {
      testWidgets(
        'The value of parameter elevation should be used to elevate the AppBar, if provided',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              theme: lightTheme(),
              home: Scaffold(
                appBar: CleanAppBar(
                  elevation: 3.0,
                ),
              ),
            ),
          );

          expect(
            find.byWidgetPredicate(
              (widget) => widget is AppBar && widget.elevation == 3.0,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'The default value of property elevation should be 0.0',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              theme: lightTheme(),
              home: Scaffold(
                appBar: CleanAppBar(),
              ),
            ),
          );

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
        'The value of parameter titleTextStyle should be used to style the title, if provided',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              theme: lightTheme(),
              home: Scaffold(
                appBar: CleanAppBar(
                  title: 'Home',
                  titleTextStyle: TextStyle(
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
        'CleanAppBar should use headline6 colored with kPrimaryColor as default value of property titleTextStyle',
        (WidgetTester tester) async {
          late BuildContext ctx;

          await tester.pumpWidget(
            MaterialApp(
              theme: lightTheme(),
              home: Builder(builder: (context) {
                ctx = context;
                return Scaffold(
                  appBar: CleanAppBar(
                    title: 'Home',
                  ),
                );
              }),
            ),
          );

          find.descendant(
            of: find.byType(CleanAppBar),
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is AppBar &&
                  widget.titleTextStyle?.color == ctx.colors.primaryColor,
            ),
          );
        },
      );
    },
  );
}
