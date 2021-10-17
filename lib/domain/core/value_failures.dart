import 'package:freezed_annotation/freezed_annotation.dart';

part 'value_failures.freezed.dart';

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
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

}