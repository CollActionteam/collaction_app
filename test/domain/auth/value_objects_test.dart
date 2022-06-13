import 'package:collaction_app/domain/auth/value_objects.dart';
import 'package:flutter_test/flutter_test.dart';

import 'auth_fixtures.dart';

void main() {
  test('Testing PhoneNumber instance', () {
    expect(PhoneNumber(validPhone).value.isRight(), true);
    expect(PhoneNumber(invalidPhone).value.isLeft(), true);
  });
  test('Testing EmailAddress instance', () {
    expect(EmailAddress(validEmail).value.isRight(), true);
    expect(EmailAddress(invalidEmail).value.isLeft(), true);
  });
  test('Testing Username instance', () {
    expect(Username(invalidUsername).value.isLeft(), true);
    expect(Username(validUsername).value.isRight(), true);
  });
}
