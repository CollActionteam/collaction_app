part of 'country_bloc.dart';

@freezed
class CountryEvent with _$CountryEvent {
  const factory CountryEvent.updateCountry({
    required String countryName,
    required String countrycode,
  }) = _UpdateCountry;
}
