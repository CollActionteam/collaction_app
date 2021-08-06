// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'crowdaction_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CrowdActionDto _$CrowdActionDtoFromJson(Map<String, dynamic> json) {
  return _CrowdActionDto.fromJson(json);
}

/// @nodoc
class _$CrowdActionDtoTearOff {
  const _$CrowdActionDtoTearOff();

  _CrowdActionDto call(
      {required String name,
      required String description,
      required DateTime start,
      required DateTime end}) {
    return _CrowdActionDto(
      name: name,
      description: description,
      start: start,
      end: end,
    );
  }

  CrowdActionDto fromJson(Map<String, Object> json) {
    return CrowdActionDto.fromJson(json);
  }
}

/// @nodoc
const $CrowdActionDto = _$CrowdActionDtoTearOff();

/// @nodoc
mixin _$CrowdActionDto {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get start => throw _privateConstructorUsedError;
  DateTime get end => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CrowdActionDtoCopyWith<CrowdActionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CrowdActionDtoCopyWith<$Res> {
  factory $CrowdActionDtoCopyWith(
          CrowdActionDto value, $Res Function(CrowdActionDto) then) =
      _$CrowdActionDtoCopyWithImpl<$Res>;
  $Res call({String name, String description, DateTime start, DateTime end});
}

/// @nodoc
class _$CrowdActionDtoCopyWithImpl<$Res>
    implements $CrowdActionDtoCopyWith<$Res> {
  _$CrowdActionDtoCopyWithImpl(this._value, this._then);

  final CrowdActionDto _value;
  // ignore: unused_field
  final $Res Function(CrowdActionDto) _then;

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
abstract class _$CrowdActionDtoCopyWith<$Res>
    implements $CrowdActionDtoCopyWith<$Res> {
  factory _$CrowdActionDtoCopyWith(
          _CrowdActionDto value, $Res Function(_CrowdActionDto) then) =
      __$CrowdActionDtoCopyWithImpl<$Res>;
  @override
  $Res call({String name, String description, DateTime start, DateTime end});
}

/// @nodoc
class __$CrowdActionDtoCopyWithImpl<$Res>
    extends _$CrowdActionDtoCopyWithImpl<$Res>
    implements _$CrowdActionDtoCopyWith<$Res> {
  __$CrowdActionDtoCopyWithImpl(
      _CrowdActionDto _value, $Res Function(_CrowdActionDto) _then)
      : super(_value, (v) => _then(v as _CrowdActionDto));

  @override
  _CrowdActionDto get _value => super._value as _CrowdActionDto;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? start = freezed,
    Object? end = freezed,
  }) {
    return _then(_CrowdActionDto(
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
@JsonSerializable()
class _$_CrowdActionDto extends _CrowdActionDto {
  _$_CrowdActionDto(
      {required this.name,
      required this.description,
      required this.start,
      required this.end})
      : super._();

  factory _$_CrowdActionDto.fromJson(Map<String, dynamic> json) =>
      _$_$_CrowdActionDtoFromJson(json);

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
    return 'CrowdActionDto(name: $name, description: $description, start: $start, end: $end)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CrowdActionDto &&
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
  _$CrowdActionDtoCopyWith<_CrowdActionDto> get copyWith =>
      __$CrowdActionDtoCopyWithImpl<_CrowdActionDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CrowdActionDtoToJson(this);
  }
}

abstract class _CrowdActionDto extends CrowdActionDto {
  factory _CrowdActionDto(
      {required String name,
      required String description,
      required DateTime start,
      required DateTime end}) = _$_CrowdActionDto;
  _CrowdActionDto._() : super._();

  factory _CrowdActionDto.fromJson(Map<String, dynamic> json) =
      _$_CrowdActionDto.fromJson;

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
  _$CrowdActionDtoCopyWith<_CrowdActionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

CrowdActionList _$CrowdActionListFromJson(Map<String, dynamic> json) {
  return _CrowdActionList.fromJson(json);
}

/// @nodoc
class _$CrowdActionListTearOff {
  const _$CrowdActionListTearOff();

  _CrowdActionList call({required List<CrowdActionDto> crowdactions}) {
    return _CrowdActionList(
      crowdactions: crowdactions,
    );
  }

  CrowdActionList fromJson(Map<String, Object> json) {
    return CrowdActionList.fromJson(json);
  }
}

/// @nodoc
const $CrowdActionList = _$CrowdActionListTearOff();

/// @nodoc
mixin _$CrowdActionList {
  List<CrowdActionDto> get crowdactions => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CrowdActionListCopyWith<CrowdActionList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CrowdActionListCopyWith<$Res> {
  factory $CrowdActionListCopyWith(
          CrowdActionList value, $Res Function(CrowdActionList) then) =
      _$CrowdActionListCopyWithImpl<$Res>;
  $Res call({List<CrowdActionDto> crowdactions});
}

/// @nodoc
class _$CrowdActionListCopyWithImpl<$Res>
    implements $CrowdActionListCopyWith<$Res> {
  _$CrowdActionListCopyWithImpl(this._value, this._then);

  final CrowdActionList _value;
  // ignore: unused_field
  final $Res Function(CrowdActionList) _then;

  @override
  $Res call({
    Object? crowdactions = freezed,
  }) {
    return _then(_value.copyWith(
      crowdactions: crowdactions == freezed
          ? _value.crowdactions
          : crowdactions // ignore: cast_nullable_to_non_nullable
              as List<CrowdActionDto>,
    ));
  }
}

/// @nodoc
abstract class _$CrowdActionListCopyWith<$Res>
    implements $CrowdActionListCopyWith<$Res> {
  factory _$CrowdActionListCopyWith(
          _CrowdActionList value, $Res Function(_CrowdActionList) then) =
      __$CrowdActionListCopyWithImpl<$Res>;
  @override
  $Res call({List<CrowdActionDto> crowdactions});
}

/// @nodoc
class __$CrowdActionListCopyWithImpl<$Res>
    extends _$CrowdActionListCopyWithImpl<$Res>
    implements _$CrowdActionListCopyWith<$Res> {
  __$CrowdActionListCopyWithImpl(
      _CrowdActionList _value, $Res Function(_CrowdActionList) _then)
      : super(_value, (v) => _then(v as _CrowdActionList));

  @override
  _CrowdActionList get _value => super._value as _CrowdActionList;

  @override
  $Res call({
    Object? crowdactions = freezed,
  }) {
    return _then(_CrowdActionList(
      crowdactions: crowdactions == freezed
          ? _value.crowdactions
          : crowdactions // ignore: cast_nullable_to_non_nullable
              as List<CrowdActionDto>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CrowdActionList extends _CrowdActionList {
  _$_CrowdActionList({required this.crowdactions}) : super._();

  factory _$_CrowdActionList.fromJson(Map<String, dynamic> json) =>
      _$_$_CrowdActionListFromJson(json);

  @override
  final List<CrowdActionDto> crowdactions;

  @override
  String toString() {
    return 'CrowdActionList(crowdactions: $crowdactions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CrowdActionList &&
            (identical(other.crowdactions, crowdactions) ||
                const DeepCollectionEquality()
                    .equals(other.crowdactions, crowdactions)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(crowdactions);

  @JsonKey(ignore: true)
  @override
  _$CrowdActionListCopyWith<_CrowdActionList> get copyWith =>
      __$CrowdActionListCopyWithImpl<_CrowdActionList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CrowdActionListToJson(this);
  }
}

abstract class _CrowdActionList extends CrowdActionList {
  factory _CrowdActionList({required List<CrowdActionDto> crowdactions}) =
      _$_CrowdActionList;
  _CrowdActionList._() : super._();

  factory _CrowdActionList.fromJson(Map<String, dynamic> json) =
      _$_CrowdActionList.fromJson;

  @override
  List<CrowdActionDto> get crowdactions => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CrowdActionListCopyWith<_CrowdActionList> get copyWith =>
      throw _privateConstructorUsedError;
}
