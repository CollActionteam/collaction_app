import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/user/i_user_repository.dart';
import '../../domain/user/user.dart';

part 'user_details_bloc.freezed.dart';
part 'user_details_event.dart';
part 'user_details_state.dart';

@injectable
class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final IUserRepository _userRepository;
  UserDetailsBloc(this._userRepository)
      : super(const UserDetailsState.initial()) {
    on<UserDetailsEvent>(
      (event, emit) async {
        await event.map(
          fetchDetails: (event) async => await _fetchDetails(emit, event),
        );
      },
    );
  }

  FutureOr<void> _fetchDetails(
    Emitter<UserDetailsState> emit,
    _FetchDetails fetchDetails,
  ) async {
    emit(const UserDetailsState.fetchingDetails());

    final Stream<User> signedInUser = _userRepository.observeUser();

    if (signedInUser is User) {
      emit(UserDetailsState.fetchingDetailsSuccessful(signedInUser));
    } else {
      emit(const UserDetailsState.fetchingDetailsFailed());
    }
  }
}
