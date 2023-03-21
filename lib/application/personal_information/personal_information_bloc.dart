// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/profile/user_profile.dart';
import '../../domain/user/i_profile_repository.dart';

part 'personal_information_event.dart';
part 'personal_information_state.dart';
part 'personal_information_bloc.freezed.dart';

@injectable
class PersonalInformationBloc
    extends Bloc<PersonalInformationEvent, PersonalInformationState> {
  final IProfileRepository _profileRepository;

  PersonalInformationBloc(this._profileRepository) : super(_Fetching()) {
    _profileRepository.getUserProfile().then((profileOrFailure) {
      profileOrFailure.fold((l) {}, (profile) {
        emit(PersonalInformationState.fetched(profile));
      });
    });
  }
}
