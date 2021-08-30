part of 'auth_bloc.dart';

@freezed
class AuthBlocEvent with _$AuthBlocEvent {
  const factory AuthBlocEvent.confirmCode(String code) = _ConfirmCode;
  const factory AuthBlocEvent.updated(Credential credential, String code) =
      _Updated;
}
