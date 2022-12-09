import 'dart:io';

import 'package:collaction_app/presentation/shared_widgets/photo_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';

import '../../test_helper.dart';

void main() {
  const MethodChannel imagePickerChannel =
      MethodChannel('plugins.flutter.io/image_picker');
  const MethodChannel cropImageChannel =
      MethodChannel('plugins.hunghd.vn/image_cropper');

  bool pickImageCalled = false;
  bool cropImageCalled = false;

  setUp(() async {
    imagePickerChannel.setMockMethodCallHandler((MethodCall call) async {
      if (call.method == 'pickImage') {
        XFile? xFile = await getFileFromAssets('default_avatar.png');
        pickImageCalled = true;
        return xFile!.path;
      }
      return null;
    });

    cropImageChannel.setMockMethodCallHandler((MethodCall call) async {
      cropImageCalled = true;
      return call.arguments['source_path'];
    });
  });

  group('PhotoSelector tests:', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: PhotoSelector());
      await tester.pumpAndSettle();

      expect(find.byType(PhotoSelector), findsOneWidget);
      expect(find.text('Upload a profile photo'), findsOneWidget);
      expect(find.text('Gallery'), findsOneWidget);
      expect(find.text('Camera'), findsOneWidget);
    });

    testWidgets(
        'gallery button starts image-loading process, terminates correctly',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        pickImageCalled = false;
        cropImageCalled = false;

        await buildAndPump(tester: tester, widget: PhotoSelector());
        await tester.pumpAndSettle();

        await tester.tap(find.byType(FloatingActionButton).first);
        await tester.pumpAndSettle();
        await Future.delayed(Duration(seconds: 1));

        expect(pickImageCalled, true);
        expect(cropImageCalled, true);
      });
    });

    testWidgets(
        'camera button starts image-loading process, terminates correctly',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        pickImageCalled = false;
        cropImageCalled = false;

        await buildAndPump(tester: tester, widget: PhotoSelector());
        await tester.pumpAndSettle();

        await tester.tap(find.byType(FloatingActionButton).last);
        await tester.pumpAndSettle();
        await Future.delayed(Duration(seconds: 1));

        expect(pickImageCalled, true);
        expect(cropImageCalled, true);
      });
    });

    testWidgets('onSelected triggers after image selected',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        bool onSelectedCalled = false;
        await buildAndPump(
          tester: tester,
          widget: PhotoSelector(
            onSelected: (_) => onSelectedCalled = true,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(FloatingActionButton).last);
        await tester.pumpAndSettle();
        await Future.delayed(Duration(seconds: 1));

        expect(onSelectedCalled, true);
      });
    });
  });
}

Future<XFile?> getFileFromAssets(String filename) async {
  final byteData = await rootBundle.load('assets/images/$filename');

  final file = File('${Directory.systemTemp.path}/$filename');
  await file.writeAsBytes(
    byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
  );

  return XFile(file.path);
}
