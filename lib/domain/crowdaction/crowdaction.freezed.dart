// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'crowdaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CrowdActionTearOff {
  const _$CrowdActionTearOff();

  _CrowdAction call(
      {required String name,
      required String description,
      required DateTime start,
      required DateTime end}) {
    return _CrowdAction(
      name: name,
      description: description,
      start: start,
      end: end,
    );
  }
}

/// @nodoc
const $CrowdAction = _$CrowdActionTearOff();

/// @nodoc
mixin _$CrowdAction {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get start => throw _privateConstructorUsedError;
  DateTime get end => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CrowdActionCopyWith<CrowdAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CrowdActionCopyWith<$Res> {
  factory $CrowdActionCopyWith(
          CrowdAction value, $Res Function(CrowdAction) then) =
      _$CrowdActionCopyWithImpl<$Res>;
  $Res call({String name, String description, DateTime start, DateTime end});
}

/// @nodoc
class _$CrowdActionCopyWithImpl<$Res> implements $CrowdActionCopyWith<$Res> {
  _$CrowdActionCopyWithImpl(this._value, this._then);

  final CrowdAction _value;
  // ignore: unused_field
  final $Res Function(CrowdAction) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? start = freezed,
    Object? end = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: end == freezed
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$CrowdActionCopyWith<$Res>
    implements $CrowdActionCopyWith<$Res> {
  factory _$CrowdActionCopyWith(
          _CrowdAction value, $Res Function(_CrowdAction) then) =
      __$CrowdActionCopyWithImpl<$Res>;
  @override
  $Res call({String name, String description, DateTime start, DateTime end});
}

/// @nodoc
class __$CrowdActionCopyWithImpl<$Res> extends _$CrowdActionCopyWithImpl<$Res>
    implements _$CrowdActionCopyWith<$Res> {
  __$CrowdActionCopyWithImpl(
      _CrowdAction _value, $Res Function(_CrowdAction) _then)
      : super(_value, (v) => _then(v as _CrowdAction));

  @override
  _CrowdAction get _value => super._value as _CrowdAction;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? start = freezed,
    Object? end = freezed,
  }) {
    return _then(_CrowdAction(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: end == freezed
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_CrowdAction implements _CrowdAction {
  const _$_CrowdAction(
      {required this.name,
      required this.description,
      required this.start,
      required this.end});

  @override
  final String name;
  @override
  final String description;
  @override
  final DateTime start;
  @override
  final DateTime end;

  @override
  String toString() {
    return 'CrowdAction(name: $name, description: $description, start: $start, end: $end)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CrowdAction &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(end);

  @JsonKey(ignore: true)
  @override
  _$CrowdActionCopyWith<_CrowdAction> get copyWith =>
      __$CrowdActionCopyWithImpl<_CrowdAction>(this, _$identity);
}

abstract class _CrowdAction implements CrowdAction {
  const factory _CrowdAction(
      {required String name,
      required String description,
      required DateTime start,
      required DateTime end}) = _$_CrowdAction;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  DateTime get start => throw _privateConstructorUsedError;
  @override
  DateTime get end => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CrowdActionCopyWith<_CrowdAction> get copyWith =>
      throw _privateConstructorUsedError;
}
