import 'package:equatable/equatable.dart';

class ValueFailure<T> extends Equatable {
  final T failedValue;

  const ValueFailure({required this.failedValue});

  const factory ValueFailure.invalidPhone({
    required T failedValue,
  }) = InvalidPhone<T>;

  const factory ValueFailure.invalidEmail({
    required T failedValue,
  }) = InvalidEmail<T>;

  const factory ValueFailure.empty({
    required T failedValue,
  }) = Empty<T>;

  const factory ValueFailure.shortUsername({
    required T failedValue,
  }) = ShortUsername<T>;

  const factory ValueFailure.longUsername({
    required T failedValue,
  }) = LongUsername<T>;

  const factory ValueFailure.notStartWithLetter({
    required T failedValue,
  }) = NotStartWithLetter<T>;

  @override
  List<Object?> get props => [failedValue];
}

class InvalidPhone<T> extends ValueFailure<T> {
  const InvalidPhone({required super.failedValue});
}

class InvalidEmail<T> extends ValueFailure<T> {
  const InvalidEmail({required super.failedValue});
}

class Empty<T> extends ValueFailure<T> {
  const Empty({required super.failedValue});
}

class ShortUsername<T> extends ValueFailure<T> {
  const ShortUsername({required super.failedValue});
}

class LongUsername<T> extends ValueFailure<T> {
  const LongUsername({required super.failedValue});
}

class NotStartWithLetter<T> extends ValueFailure<T> {
  const NotStartWithLetter({required super.failedValue});
}
