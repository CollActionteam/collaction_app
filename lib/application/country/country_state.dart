part of 'country_bloc.dart';

@freezed
class CountryState with _$CountryState {
  const factory CountryState.initial() = _Initial;
  const factory CountryState.updateInProgress() = _UpdateInProgress;
  const factory CountryState.updateSuccess() = _UpdateSuccess;
  const factory CountryState.updateFailure() = _UpdateFailure;
}
