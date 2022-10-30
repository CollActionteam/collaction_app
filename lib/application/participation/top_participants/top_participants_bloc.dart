import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/participation/i_participation_repository.dart';
import '../../../domain/participation/participation.dart';

part 'top_participants_bloc.freezed.dart';
part 'top_participants_event.dart';
part 'top_participants_state.dart';

@injectable
class TopParticipantsBloc
    extends Bloc<TopParticipantsEvent, TopParticipantsState> {
  final IParticipationRepository _participationRepository;

  TopParticipantsBloc(this._participationRepository) : super(const _Initial()) {
    on<TopParticipantsEvent>((event, emit) async {
      await event.map(
        fetchParticipants: (event) async {
          emit(const TopParticipantsState.fetching());

          final participantsOrFailure = await _participationRepository
              .getTopParticipants(crowdActionId: event.crowdActionId);

          participantsOrFailure.fold(
            (failure) => emit(const TopParticipantsState.failure()),
            (participants) => emit(TopParticipantsState.fetched(participants)),
          );
        },
      );
    });
  }
}
