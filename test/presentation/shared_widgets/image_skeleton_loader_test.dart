import 'package:collaction_app/presentation/shared_widgets/image_skeleton_loader.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('ImageSkeletonLoader test:', () {
    testWidgets('can render rectangular', (WidgetTester tester) async {
      await buildAndPump(
          tester: tester, widget: ImageSkeletonLoader(height: 100));
      await tester.pump();

      expect(find.byType(ImageSkeletonLoader), findsOneWidget);
      expect(
          tester
              .firstWidget<ImageSkeletonLoader>(
                  find.byType(ImageSkeletonLoader))
              .isCircle,
          false);
    });

    testWidgets('can render circular', (WidgetTester tester) async {
      await buildAndPump(
          tester: tester,
          widget: ImageSkeletonLoader(
            height: 100,
            isCircle: true,
          ));
      await tester.pump();

      expect(find.byType(ImageSkeletonLoader), findsOneWidget);
      expect(
          tester
              .firstWidget<ImageSkeletonLoader>(
                  find.byType(ImageSkeletonLoader))
              .isCircle,
          true);
    });
  });
}
