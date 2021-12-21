import 'package:bloc/bloc.dart';
import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/user/user.dart';

part 'user_details_bloc.freezed.dart';
part 'user_details_event.dart';
part 'user_details_state.dart';

@injectable
class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final IUserRepository _userRepository;
  UserDetailsBloc(this._userRepository)
      : super(const UserDetailsState.initial());

  @override
  Stream<UserDetailsState> mapEventToState(UserDetailsEvent event) async* {
    yield* event.map(fetchDetails: _fetchDetails);
  }

  Stream<UserDetailsState> _fetchDetails(_FetchDetails fetchDetails) async* {
    yield const UserDetailsState.fetchingDetails();
    final Stream<User> signedInUser = _userRepository.observeUser();
    // final User? user = signedInUser.fold(() => null, id);
    if (signedInUser is User) {
      yield UserDetailsState.fetchingDetailsSuccessful(signedInUser);
    } else {
      yield const UserDetailsState.fetchingDetailsFailed();
    }
  }
}
