part of 'auth_bloc.dart';

@freezed
class AuthBlocState with _$AuthBlocState {
  const factory AuthBlocState.initial() = _Initial;
  const factory AuthBlocState.watching() = _Watching;
  const factory AuthBlocState.confirmed(String code) = _Confirmed;
  const factory AuthBlocState.rejected(String code) = _Rejected;
}
