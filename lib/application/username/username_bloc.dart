import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/user/i_profile_repository.dart';

part 'username_event.dart';
part 'username_state.dart';

@injectable
class UsernameBloc extends Bloc<UsernameEvent, UsernameState> {
  final IProfileRepository profileRepository;

  UsernameBloc(this.profileRepository) : super(const _Initial()) {
    on<UsernameEvent>((event, emit) async {
      if (event is _UpdateUsername) {
        emit(const UsernameState.updateInProgress());

        final unitOrFailure = await profileRepository.updateUsername(
          firstName: event.firstName,
          lastName: event.lastName,
        );

        emit(
          unitOrFailure.fold(
            (failure) => const UsernameState.updateFailure(),
            (_) => UsernameState.updateSuccess(
                "${event.firstName} ${event.lastName}"),
          ),
        );
      }
    });
  }
}
