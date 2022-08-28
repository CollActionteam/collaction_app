part of 'build_information_bloc.dart';

@freezed
class BuildInformationState with _$BuildInformationState {
  const factory BuildInformationState.loading() = _Loading;
  const factory BuildInformationState.fetched(BuildInformation buildInfo) =
      _Fetched;
}
