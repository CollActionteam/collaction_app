part of 'username_bloc.dart';

@freezed
class UsernameEvent with _$UsernameEvent {
  const factory UsernameEvent.updateUsername({
    required String firstName,
    required String lastName,
  }) = _UpdateUsername;
}
