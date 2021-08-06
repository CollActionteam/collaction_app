// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'crowdaction_getter_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CrowdActionGetterEventTearOff {
  const _$CrowdActionGetterEventTearOff();

  _GetMore getMore() {
    return const _GetMore();
  }
}

/// @nodoc
const $CrowdActionGetterEvent = _$CrowdActionGetterEventTearOff();

/// @nodoc
mixin _$CrowdActionGetterEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getMore,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getMore,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetMore value) getMore,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetMore value)? getMore,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CrowdActionGetterEventCopyWith<$Res> {
  factory $CrowdActionGetterEventCopyWith(CrowdActionGetterEvent value,
          $Res Function(CrowdActionGetterEvent) then) =
      _$CrowdActionGetterEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$CrowdActionGetterEventCopyWithImpl<$Res>
    implements $CrowdActionGetterEventCopyWith<$Res> {
  _$CrowdActionGetterEventCopyWithImpl(this._value, this._then);

  final CrowdActionGetterEvent _value;
  // ignore: unused_field
  final $Res Function(CrowdActionGetterEvent) _then;
}

/// @nodoc
abstract class _$GetMoreCopyWith<$Res> {
  factory _$GetMoreCopyWith(_GetMore value, $Res Function(_GetMore) then) =
      __$GetMoreCopyWithImpl<$Res>;
}

/// @nodoc
class __$GetMoreCopyWithImpl<$Res>
    extends _$CrowdActionGetterEventCopyWithImpl<$Res>
    implements _$GetMoreCopyWith<$Res> {
  __$GetMoreCopyWithImpl(_GetMore _value, $Res Function(_GetMore) _then)
      : super(_value, (v) => _then(v as _GetMore));

  @override
  _GetMore get _value => super._value as _GetMore;
}

/// @nodoc

class _$_GetMore implements _GetMore {
  const _$_GetMore();

  @override
  String toString() {
    return 'CrowdActionGetterEvent.getMore()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _GetMore);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getMore,
  }) {
    return getMore();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getMore,
    required TResult orElse(),
  }) {
    if (getMore != null) {
      return getMore();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetMore value) getMore,
  }) {
    return getMore(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetMore value)? getMore,
    required TResult orElse(),
  }) {
    if (getMore != null) {
      return getMore(this);
    }
    return orElse();
  }
}

abstract class _GetMore implements CrowdActionGetterEvent {
  const factory _GetMore() = _$_GetMore;
}

/// @nodoc
class _$CrowdActionGetterStateTearOff {
  const _$CrowdActionGetterStateTearOff();

  _Initial initial() {
    return const _Initial();
  }

  _FetchingCrowdActions fetchingCrowdActions() {
    return const _FetchingCrowdActions();
  }

  _NoCrowdActions noCrowdActions() {
    return const _NoCrowdActions();
  }

  _Fetched fetched(List<CrowdAction> crowdActions) {
    return _Fetched(
      crowdActions,
    );
  }
}

/// @nodoc
const $CrowdActionGetterState = _$CrowdActionGetterStateTearOff();

/// @nodoc
mixin _$CrowdActionGetterState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchingCrowdActions,
    required TResult Function() noCrowdActions,
    required TResult Function(List<CrowdAction> crowdActions) fetched,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchingCrowdActions,
    TResult Function()? noCrowdActions,
    TResult Function(List<CrowdAction> crowdActions)? fetched,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchingCrowdActions value) fetchingCrowdActions,
    required TResult Function(_NoCrowdActions value) noCrowdActions,
    required TResult Function(_Fetched value) fetched,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchingCrowdActions value)? fetchingCrowdActions,
    TResult Function(_NoCrowdActions value)? noCrowdActions,
    TResult Function(_Fetched value)? fetched,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CrowdActionGetterStateCopyWith<$Res> {
  factory $CrowdActionGetterStateCopyWith(CrowdActionGetterState value,
          $Res Function(CrowdActionGetterState) then) =
      _$CrowdActionGetterStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$CrowdActionGetterStateCopyWithImpl<$Res>
    implements $CrowdActionGetterStateCopyWith<$Res> {
  _$CrowdActionGetterStateCopyWithImpl(this._value, this._then);

  final CrowdActionGetterState _value;
  // ignore: unused_field
  final $Res Function(CrowdActionGetterState) _then;
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res>
    extends _$CrowdActionGetterStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'CrowdActionGetterState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchingCrowdActions,
    required TResult Function() noCrowdActions,
    required TResult Function(List<CrowdAction> crowdActions) fetched,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchingCrowdActions,
    TResult Function()? noCrowdActions,
    TResult Function(List<CrowdAction> crowdActions)? fetched,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchingCrowdActions value) fetchingCrowdActions,
    required TResult Function(_NoCrowdActions value) noCrowdActions,
    required TResult Function(_Fetched value) fetched,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchingCrowdActions value)? fetchingCrowdActions,
    TResult Function(_NoCrowdActions value)? noCrowdActions,
    TResult Function(_Fetched value)? fetched,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements CrowdActionGetterState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$FetchingCrowdActionsCopyWith<$Res> {
  factory _$FetchingCrowdActionsCopyWith(_FetchingCrowdActions value,
          $Res Function(_FetchingCrowdActions) then) =
      __$FetchingCrowdActionsCopyWithImpl<$Res>;
}

/// @nodoc
class __$FetchingCrowdActionsCopyWithImpl<$Res>
    extends _$CrowdActionGetterStateCopyWithImpl<$Res>
    implements _$FetchingCrowdActionsCopyWith<$Res> {
  __$FetchingCrowdActionsCopyWithImpl(
      _FetchingCrowdActions _value, $Res Function(_FetchingCrowdActions) _then)
      : super(_value, (v) => _then(v as _FetchingCrowdActions));

  @override
  _FetchingCrowdActions get _value => super._value as _FetchingCrowdActions;
}

/// @nodoc

class _$_FetchingCrowdActions implements _FetchingCrowdActions {
  const _$_FetchingCrowdActions();

  @override
  String toString() {
    return 'CrowdActionGetterState.fetchingCrowdActions()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _FetchingCrowdActions);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchingCrowdActions,
    required TResult Function() noCrowdActions,
    required TResult Function(List<CrowdAction> crowdActions) fetched,
  }) {
    return fetchingCrowdActions();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchingCrowdActions,
    TResult Function()? noCrowdActions,
    TResult Function(List<CrowdAction> crowdActions)? fetched,
    required TResult orElse(),
  }) {
    if (fetchingCrowdActions != null) {
      return fetchingCrowdActions();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchingCrowdActions value) fetchingCrowdActions,
    required TResult Function(_NoCrowdActions value) noCrowdActions,
    required TResult Function(_Fetched value) fetched,
  }) {
    return fetchingCrowdActions(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchingCrowdActions value)? fetchingCrowdActions,
    TResult Function(_NoCrowdActions value)? noCrowdActions,
    TResult Function(_Fetched value)? fetched,
    required TResult orElse(),
  }) {
    if (fetchingCrowdActions != null) {
      return fetchingCrowdActions(this);
    }
    return orElse();
  }
}

abstract class _FetchingCrowdActions implements CrowdActionGetterState {
  const factory _FetchingCrowdActions() = _$_FetchingCrowdActions;
}

/// @nodoc
abstract class _$NoCrowdActionsCopyWith<$Res> {
  factory _$NoCrowdActionsCopyWith(
          _NoCrowdActions value, $Res Function(_NoCrowdActions) then) =
      __$NoCrowdActionsCopyWithImpl<$Res>;
}

/// @nodoc
class __$NoCrowdActionsCopyWithImpl<$Res>
    extends _$CrowdActionGetterStateCopyWithImpl<$Res>
    implements _$NoCrowdActionsCopyWith<$Res> {
  __$NoCrowdActionsCopyWithImpl(
      _NoCrowdActions _value, $Res Function(_NoCrowdActions) _then)
      : super(_value, (v) => _then(v as _NoCrowdActions));

  @override
  _NoCrowdActions get _value => super._value as _NoCrowdActions;
}

/// @nodoc

class _$_NoCrowdActions implements _NoCrowdActions {
  const _$_NoCrowdActions();

  @override
  String toString() {
    return 'CrowdActionGetterState.noCrowdActions()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _NoCrowdActions);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchingCrowdActions,
    required TResult Function() noCrowdActions,
    required TResult Function(List<CrowdAction> crowdActions) fetched,
  }) {
    return noCrowdActions();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchingCrowdActions,
    TResult Function()? noCrowdActions,
    TResult Function(List<CrowdAction> crowdActions)? fetched,
    required TResult orElse(),
  }) {
    if (noCrowdActions != null) {
      return noCrowdActions();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchingCrowdActions value) fetchingCrowdActions,
    required TResult Function(_NoCrowdActions value) noCrowdActions,
    required TResult Function(_Fetched value) fetched,
  }) {
    return noCrowdActions(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchingCrowdActions value)? fetchingCrowdActions,
    TResult Function(_NoCrowdActions value)? noCrowdActions,
    TResult Function(_Fetched value)? fetched,
    required TResult orElse(),
  }) {
    if (noCrowdActions != null) {
      return noCrowdActions(this);
    }
    return orElse();
  }
}

abstract class _NoCrowdActions implements CrowdActionGetterState {
  const factory _NoCrowdActions() = _$_NoCrowdActions;
}

/// @nodoc
abstract class _$FetchedCopyWith<$Res> {
  factory _$FetchedCopyWith(_Fetched value, $Res Function(_Fetched) then) =
      __$FetchedCopyWithImpl<$Res>;
  $Res call({List<CrowdAction> crowdActions});
}

/// @nodoc
class __$FetchedCopyWithImpl<$Res>
    extends _$CrowdActionGetterStateCopyWithImpl<$Res>
    implements _$FetchedCopyWith<$Res> {
  __$FetchedCopyWithImpl(_Fetched _value, $Res Function(_Fetched) _then)
      : super(_value, (v) => _then(v as _Fetched));

  @override
  _Fetched get _value => super._value as _Fetched;

  @override
  $Res call({
    Object? crowdActions = freezed,
  }) {
    return _then(_Fetched(
      crowdActions == freezed
          ? _value.crowdActions
          : crowdActions // ignore: cast_nullable_to_non_nullable
              as List<CrowdAction>,
    ));
  }
}

/// @nodoc

class _$_Fetched implements _Fetched {
  const _$_Fetched(this.crowdActions);

  @override
  final List<CrowdAction> crowdActions;

  @override
  String toString() {
    return 'CrowdActionGetterState.fetched(crowdActions: $crowdActions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Fetched &&
            (identical(other.crowdActions, crowdActions) ||
                const DeepCollectionEquality()
                    .equals(other.crowdActions, crowdActions)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(crowdActions);

  @JsonKey(ignore: true)
  @override
  _$FetchedCopyWith<_Fetched> get copyWith =>
      __$FetchedCopyWithImpl<_Fetched>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() fetchingCrowdActions,
    required TResult Function() noCrowdActions,
    required TResult Function(List<CrowdAction> crowdActions) fetched,
  }) {
    return fetched(crowdActions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? fetchingCrowdActions,
    TResult Function()? noCrowdActions,
    TResult Function(List<CrowdAction> crowdActions)? fetched,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(crowdActions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_FetchingCrowdActions value) fetchingCrowdActions,
    required TResult Function(_NoCrowdActions value) noCrowdActions,
    required TResult Function(_Fetched value) fetched,
  }) {
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_FetchingCrowdActions value)? fetchingCrowdActions,
    TResult Function(_NoCrowdActions value)? noCrowdActions,
    TResult Function(_Fetched value)? fetched,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class _Fetched implements CrowdActionGetterState {
  const factory _Fetched(List<CrowdAction> crowdActions) = _$_Fetched;

  List<CrowdAction> get crowdActions => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$FetchedCopyWith<_Fetched> get copyWith =>
      throw _privateConstructorUsedError;
}
