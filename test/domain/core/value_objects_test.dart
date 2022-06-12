import 'package:collaction_app/domain/core/value_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'core_fixtures.dart';

void main() {
  final mockValueObjectS = MockValueObjects(right(inputString));
  final mockValueObjectF =
      MockValueObjects(left(const ValueFailure.empty(failedValue: '')));

  test('Testing getOrCrash() method Success', () {
    final response = mockValueObjectS.getOrCrash();
    expect(response, 'testString');
  });

  test('Testing isValid function', () {
    expect(mockValueObjectS.isValid(), true);
    expect(mockValueObjectF.isValid(), false);
  });

  test('Testing failureOrUnit method', () {
    expect(mockValueObjectS.failureOrUnit, right(unit));
    expect(
      mockValueObjectF.failureOrUnit,
      left(const ValueFailure.empty(failedValue: '')),
    );
  });

  test('Testing prop() function', () {
    expect(mockValueObjectS.props, [right(inputString)]);
    expect(
      mockValueObjectF.props,
      [left(const ValueFailure.empty(failedValue: ''))],
    );
  });

  test('Testing toString() function', () {
    expect(mockValueObjectS.toString(), 'Value(${right(inputString)})');
    expect(
      mockValueObjectF.toString(),
      'Value(${left(const ValueFailure.empty(failedValue: ''))})',
    );
  });
}
