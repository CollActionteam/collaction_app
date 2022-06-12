import 'package:collaction_app/domain/core/value_failures.dart';
import 'package:collaction_app/domain/core/value_objects.dart';
import 'package:dartz/dartz.dart';

class MockValueObjects extends ValueObject {
  @override
  // TODO: implement value
  Either<ValueFailure, dynamic> get value => throw UnimplementedError();
}

const inputEmptyString = '';
const inputString = 'testString';

const explanation =
    "Encountered an error at an unrecoverable point.Terminating.";

const failure = ValueFailure.invalidEmail(failedValue: 'inValidEmail');
