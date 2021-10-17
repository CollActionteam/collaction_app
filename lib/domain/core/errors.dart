import 'value_failures.dart';

class UnExpectedValueError extends Error {
  final ValueFailure failure;

  UnExpectedValueError(this.failure);

  @override
  String toString() {
    const explanation =
        "Encountered an error at an unrecoverable point.Terminating.";
    return Error.safeToString("$explanation Failure was: $failure");
  }
}
