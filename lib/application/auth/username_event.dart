part of 'username_bloc.dart';

@freezed
class UsernameEvent with _$UsernameEvent {
  const factory UsernameEvent.updateUsername(
    String firstname,
    String lastname,
  ) = _UpdateUsername;
}
