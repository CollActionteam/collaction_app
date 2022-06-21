import 'package:collaction_app/domain/core/errors.dart';
import 'package:flutter_test/flutter_test.dart';

import 'core_fixtures.dart';

void main() {
  final unexpectedValueError = UnExpectedValueError(failure);
  test('Testing errors ', () {
    expect(
      unexpectedValueError.toString(),
      Error.safeToString('$explanation Failure was: $failure'),
    );
  });
}
