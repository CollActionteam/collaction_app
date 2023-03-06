part of 'build_information_bloc.dart';

abstract class BuildInformationEvent {
  const BuildInformationEvent();

  const factory BuildInformationEvent.fetch() = _Fetch;
}

class _Fetch extends BuildInformationEvent {
  const _Fetch();
}
