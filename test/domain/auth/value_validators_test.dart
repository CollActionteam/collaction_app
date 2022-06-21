import 'package:collaction_app/domain/auth/value_validators.dart';
import 'package:collaction_app/domain/core/value_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'auth_fixtures.dart';

void main() {
  group("Auth Value validators", () {
    test('Validate Phone number with valid number returns right', () {
      final validation = validatePhone(validPhone);

      expect(validation.isRight(), true);
    });

    test('Validate Phone number with invalid number returns left', () {
      final validation = validatePhone(invalidPhone);

      expect(validation.isLeft(), true);
    });

    test('Testing validateEmailAddress() method', () {
      final invalidEmailResponse = validateEmailAddress(invalidEmail);
      expect(
        invalidEmailResponse,
        left(
          const ValueFailure.invalidEmail(failedValue: invalidEmail),
        ),
      );

      final validEmailResponse = validateEmailAddress(validEmail);
      expect(
        validEmailResponse,
        right(validEmail),
      );
    });

    test('Testing validateUsername() method', () {
      expect(
        validateUsername(emptyUsername),
        left(const ValueFailure.empty(failedValue: emptyUsername)),
      );
      expect(
        validateUsername(shortUsername),
        left(const ValueFailure.shortUsername(failedValue: shortUsername)),
      );
      expect(
        validateUsername(longUsername),
        left(const ValueFailure.longUsername(failedValue: longUsername)),
      );
      expect(
        validateUsername(invalidUsername),
        left(
          const ValueFailure.notStartWithLetter(
            failedValue: invalidUsername,
          ),
        ),
      );
      expect(
        validateUsername(validUsername),
        right(validUsername),
      );
    });
  });
}
