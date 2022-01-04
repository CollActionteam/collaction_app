part of 'user_details_bloc.dart';

@freezed
class UserDetailsState with _$UserDetailsState {
  const factory UserDetailsState.initial() = _Initial;
  const factory UserDetailsState.fetchingDetails() = _FetchingDetails;
  const factory UserDetailsState.fetchingDetailsSuccessful(Stream<User>? user) =
      _FetchingDetailsSuccessful;
  const factory UserDetailsState.fetchingDetailsFailed() =
      _FetchingDetailsFailed;
}
