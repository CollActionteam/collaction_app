part of 'crowdaction_getter_bloc.dart';

@freezed
class CrowdActionGetterEvent with _$CrowdActionGetterEvent {
  const factory CrowdActionGetterEvent.init() = _Init;
  const factory CrowdActionGetterEvent.getCrowdActions({
    @Default(1) int pageNumber,
  }) = _GetCrowdActions;
}
