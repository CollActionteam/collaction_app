import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'profile_description_event.dart';
part 'profile_description_state.dart';
part 'profile_description_bloc.freezed.dart';

@injectable
class ProfileDescriptionBloc
    extends Bloc<ProfileDescriptionEvent, ProfileDescriptionState> {
  ProfileDescriptionBloc() : super(const ProfileDescriptionState.initial());

  @override
  Stream<ProfileDescriptionState> mapEventToState(
      ProfileDescriptionEvent event) async* {
    yield* event.map(
      editProfilePressed: _editProfilePressed,
      saveChangesPressed: _saveChangesPressed,
      cancelPressed: _cancelPressed,
    );
  }

  Stream<ProfileDescriptionState> _editProfilePressed(
      _EditProfilePressed _) async* {
    yield const ProfileDescriptionState.modifyingDescription();
  }

  Stream<ProfileDescriptionState> _saveChangesPressed(
      _SaveChangesPressed _) async* {
    yield const ProfileDescriptionState.updatingDescription();
  }

  Stream<ProfileDescriptionState> _cancelPressed(_CancelPressed _) async* {
    yield const ProfileDescriptionState.updatingDescription();
  }
}
