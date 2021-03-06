import 'package:collaction_app/domain/core/value_failures.dart';
import 'package:collaction_app/domain/core/value_objects.dart';
import 'package:dartz/dartz.dart';

class MockValueObjects extends ValueObject<String> {
  const MockValueObjects(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

const inputEmptyString = '';
const inputString = 'testString';

const explanation =
    "Encountered an error at an unrecoverable point.Terminating.";

const failure = ValueFailure.invalidEmail(failedValue: 'inValidEmail');
