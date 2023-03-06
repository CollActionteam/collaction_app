part of 'username_bloc.dart';

abstract class UsernameEvent extends Equatable {
  const UsernameEvent();

  const factory UsernameEvent.updateUsername({
    required String firstName,
    required String lastName,
  }) = _UpdateUsername;
}

class _UpdateUsername extends UsernameEvent {
  final String firstName;
  final String lastName;

  const _UpdateUsername({required this.firstName, required this.lastName});

  @override
  List<Object?> get props => [firstName, lastName];
}
