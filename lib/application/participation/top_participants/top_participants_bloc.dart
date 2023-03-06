import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/participation/i_participation_repository.dart';
import '../../../domain/participation/participation.dart';

part 'top_participants_event.dart';
part 'top_participants_state.dart';

@injectable
class TopParticipantsBloc
    extends Bloc<TopParticipantsEvent, TopParticipantsState> {
  final IParticipationRepository _participationRepository;

  TopParticipantsBloc(this._participationRepository) : super(const _Initial()) {
    on<TopParticipantsEvent>((event, emit) async {
      if (event is _FetchParticipants) {
        emit(const TopParticipantsState.fetching());

        final participantsOrFailure = await _participationRepository
            .getTopParticipants(crowdActionId: event.crowdActionId);

        participantsOrFailure.fold(
          (failure) => emit(const TopParticipantsState.failure()),
          (participants) => emit(TopParticipantsState.fetched(participants)),
        );
      }
    });
  }
}
