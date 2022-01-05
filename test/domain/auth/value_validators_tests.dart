import 'package:collaction_app/domain/auth/value_validators.dart';
// ignore: depend_on_referenced_packages
import 'package:test/test.dart';

void main() {
  group("Auth Value validators", () {
    test('validate Phone number with valid number returns right', () {
      const phone = "256 778914357";

      final validation = validatePhone(phone);

      expect(validation.isRight(), true);
    });

    test('validate Phone number with invalid number returns left', () {
      const phone = "256778914357";

      final validation = validatePhone(phone);

      expect(validation.isLeft(), true);
    });
  });
}
