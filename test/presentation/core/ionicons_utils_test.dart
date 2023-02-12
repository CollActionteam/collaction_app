import 'package:collaction_app/presentation/core/collaction_icons.dart';
import 'package:collaction_app/presentation/core/ionicons_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ionicons/ionicons.dart';

void main() {
  group('IonIcons Utils tests', () {
    test('does exist', () {
      final icon = IconUtil.fromString('accessibility-outline');
      expect(icon, Ionicons.accessibility_outline);
    });

    test('does not exist', () {
      final icon = IconUtil.fromString('collaction-no-icon');
      expect(icon, CollactionIcons.collaction);
    });
  });
}
