import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> buildAndPump({
  required WidgetTester tester,
  required Widget widget,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: widget,
        ),
      ),
    ),
  );
}
