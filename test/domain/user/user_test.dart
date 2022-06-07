import 'package:collaction_app/domain/user/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test for User DTO', () {
    test('Testing getAnonymousToken method', () {
      expect(User.getAnonymousIdToken(), isA<Future<String?>>());
    });
  });
}
