part of 'username_bloc.dart';

@freezed
class UsernameState with _$UsernameState {
  const factory UsernameState.initial() = _Initial;
  const factory UsernameState.awaitingUsernameUpdate() = AwaitingUsernameUpdate;
  const factory UsernameState.updateFailed() = _UsernameUpdateError;
  const factory UsernameState.usernameUpdateSuccessful() =
      _UsernameUpdateSuccessful;
}
