part of 'username_bloc.dart';

abstract class UsernameState extends Equatable {
  const UsernameState();

  const factory UsernameState.initial() = _Initial;
  const factory UsernameState.updateInProgress() = _UpdateInProgress;
  const factory UsernameState.updateSuccess(String fullname) = _UpdateSuccess;
  const factory UsernameState.updateFailure() = _UpdateFailure;

  @override
  List<Object?> get props => [];
}

class _Initial extends UsernameState {
  const _Initial();
}

class _UpdateInProgress extends UsernameState {
  const _UpdateInProgress();
}

class _UpdateSuccess extends UsernameState {
  final String fullname;
  const _UpdateSuccess(this.fullname);

  @override
  List<Object?> get props => [fullname];
}

class _UpdateFailure extends UsernameState {
  const _UpdateFailure();
}
