part of 'username_bloc.dart';

@freezed
class UsernameState with _$UsernameState {
  const factory UsernameState.initial() = _Initial;
  const factory UsernameState.updateInProgress() = _UpdateInProgress;
  const factory UsernameState.updateSuccess(String fullname) = _UpdateSuccess;
  const factory UsernameState.updateFailure() = _UpdateFailure;
}
