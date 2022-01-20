import 'package:collaction_app/presentation/utils/time.ext.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Time Utils", () {
    test("Seconds interval difference displays X seconds ago", () {
      const difference = 3;
      final time = DateTime.now().subtract(const Duration(seconds: difference));

      expect(time.toCommentTime(), "$difference seconds");
    });

    test("Minutes interval difference displays X minutes ago", () {
      const difference = 3;
      final time = DateTime.now().subtract(const Duration(minutes: difference));

      expect(time.toCommentTime(), "$difference minutes");
    });

    test("Hours interval difference displays X hours ago", () {
      const difference = 3;
      final time = DateTime.now().subtract(const Duration(hours: difference));

      expect(time.toCommentTime(), "$difference hours");
    });

    test("Days interval difference displays X days ago", () {
      const difference = 3;
      final time = DateTime.now().subtract(const Duration(days: difference));

      expect(time.toCommentTime(), "$difference days");
    });

    test("Months interval difference displays X months ago", () {
      const difference = 3;
      final time =
          DateTime.now().subtract(const Duration(days: difference * 30));

      expect(time.toCommentTime(), "$difference months");
    });

    test("Years interval difference displays X years ago", () {
      const difference = 3;
      final time =
          DateTime.now().subtract(const Duration(days: difference * 31 * 12));

      expect(time.toCommentTime(), "$difference years");
    });
  });
}
