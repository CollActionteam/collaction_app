import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/user/i_profile_repository.dart';

part 'username_bloc.freezed.dart';
part 'username_event.dart';
part 'username_state.dart';

@injectable
class UsernameBloc extends Bloc<UsernameEvent, UsernameState> {
  final IProfileRepository profileRepository;

  UsernameBloc(this.profileRepository) : super(const _Initial()) {
    on<UsernameEvent>((event, emit) async {
      await event.when(
        updateUsername: (firstName, lastName) async {
          emit(const UsernameState.updateInProgress());

          final unitOrFailure = await profileRepository.updateUsername(
            firstName: firstName,
            lastName: lastName,
          );

          emit(
            unitOrFailure.fold(
              (failure) => const UsernameState.updateFailure(),
              (_) => UsernameState.updateSuccess("$firstName $lastName"),
            ),
          );
        },
      );
    });
  }
}
