import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'errors.dart';
import 'value_failures.dart';

@immutable
abstract class ValueObject<T> extends Equatable {
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  /// Throws [UnExpectedValueError] containing [ValueFailure]
  ///
  /// id = identity - same as (r) => r
  T getOrCrash() => value.fold((f) => throw UnExpectedValueError(f), id);

  bool isValid() => value.isRight();

  Either<ValueFailure<dynamic>, Unit> get failureOrUnit {
    return value.fold(
      (l) => left(l),
      (_) => right(unit),
    );
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'Value($value)';
}
