part of 'build_information_bloc.dart';

abstract class BuildInformationState extends Equatable {
  const BuildInformationState();

  const factory BuildInformationState.loading() = _Loading;
  const factory BuildInformationState.fetched(BuildInformation buildInfo) =
      Fetched;

  @override
  List<Object?> get props => [];
}

class _Loading extends BuildInformationState {
  const _Loading();
}

class Fetched extends BuildInformationState {
  final BuildInformation buildInfo;

  const Fetched(this.buildInfo);

  @override
  List<Object?> get props => [buildInfo];
}
