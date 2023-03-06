part of 'build_information_bloc.dart';

abstract class BuildInformationState extends Equatable {
  const BuildInformationState();

  const factory BuildInformationState.loading() = _Loading;
  const factory BuildInformationState.fetched(BuildInformation buildInfo) =
      _Fetched;

  @override
  List<Object?> get props => [];
}

class _Loading extends BuildInformationState {
  const _Loading();
}

class _Fetched extends BuildInformationState {
  final BuildInformation buildInfo;

  const _Fetched(this.buildInfo);

  @override
  List<Object?> get props => [buildInfo];
}
