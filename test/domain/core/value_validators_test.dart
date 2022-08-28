import 'package:collaction_app/domain/core/value_failures.dart';
import 'package:collaction_app/domain/core/value_validators.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'core_fixtures.dart';

void main() {
  test('Testing validate string when string EMPTY', () {
    final response = validateStringNotEmpty(inputEmptyString);
    expect(response, left(const ValueFailure.empty(failedValue: '')));
  });
  test('Testing validate string when string is NOT EMPTY', () {
    final response = validateStringNotEmpty(inputString);
    expect(response, right(inputString));
  });
}
