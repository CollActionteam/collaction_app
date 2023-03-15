part of 'personal_information_bloc.dart';

@freezed
class PersonalInformationState with _$PersonalInformationState {
  const factory PersonalInformationState.fetching() = _Fetching;
  const factory PersonalInformationState.fetched(UserProfile profile) =
      _Fetched;
}
