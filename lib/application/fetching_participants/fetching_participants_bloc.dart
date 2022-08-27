import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/crowdaction/participant.dart';
import '../../domain/user/i_profile_repository.dart';
import '../../domain/user/profile_failure.dart';

part 'fetching_participants_event.dart';
part 'fetching_participants_state.dart';

part 'fetching_participants_bloc.freezed.dart';

@injectable
class FetchingParticipantsBloc
    extends Bloc<FetchingParticipantsEvent, FetchingParticipantsState> {
  final IProfileRepository _profileRepository;
  FetchingParticipantsBloc(this._profileRepository)
      : super(const FetchingParticipantsState.initial()) {
    on<FetchingParticipantsEvent>(
      (event, emit) => event.map(
        fetchParticipants: (_fetch) async {
          emit(
            const FetchingParticipantsState.fetchingParticipants(),
          );
          final response = await _profileRepository.fetchParticipantsProfile(
            crowdactionId: _fetch.crowdactionId,
            page: _fetch.page,
          );

          return response.fold(
              (failure) => emit(
                    FetchingParticipantsState.failure(failure),
                  ), (participants) {

            return emit(
              FetchingParticipantsState.fetched(participants),
            );
          });
        },
      ),
    );
  }
}
