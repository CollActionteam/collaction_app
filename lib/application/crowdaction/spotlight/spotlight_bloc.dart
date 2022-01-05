import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../../domain/crowdaction/crowdaction_failures.dart';
import '../../../domain/crowdaction/i_crowdaction_repository.dart';

part 'spotlight_bloc.freezed.dart';
part 'spotlight_event.dart';
part 'spotlight_state.dart';

@injectable
class SpotlightBloc extends Bloc<SpotlightEvent, SpotlightState> {
  final ICrowdActionRepository _crowdActionRepository;

  SpotlightBloc(this._crowdActionRepository)
      : super(const SpotlightState.initial()) {
    on<SpotlightEvent>(
      (event, emit) async {
        await event.map(
          getSpotLightCrowdActions: (event) async =>
              await _mapGetSpotLightCrowdActionsToState(emit, event),
        );
      },
    );
  }

  FutureOr<void> _mapGetSpotLightCrowdActionsToState(
    Emitter<SpotlightState> emit,
    _GetSpotlightCrowdActions event,
  ) async {
    emit(const SpotlightState.fetchingCrowdSpotLightActions());

    final spotlightCrowdActionsResult =
        await _crowdActionRepository.getSpotlightCrowdActions();

    emit(
      spotlightCrowdActionsResult.fold(
        (failure) => SpotlightState.spotLightCrowdActionsError(failure),
        (spotLightCrowdActions) =>
            SpotlightState.spotLightCrowdActions(spotLightCrowdActions),
      ),
    );
  }
}
