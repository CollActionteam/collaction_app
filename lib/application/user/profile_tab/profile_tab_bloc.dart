import 'package:bloc/bloc.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/domain/crowdaction/i_crowdaction_repository.dart';
import 'package:injectable/injectable.dart';

part 'profile_tab_event.dart';
part 'profile_tab_state.dart';

@injectable
class ProfileTabBloc extends Bloc<ProfileTabEvent, ProfileTabState> {
  final ICrowdActionRepository crowdActionRepository;

  ProfileTabBloc({required this.crowdActionRepository})
      : super(ProfileTabState.initial()) {
    on<FetchProfileTabInfo>((event, emit) async {
      final crowdActionsOrFailure =
          await crowdActionRepository.getCrowdActionsForUser();

      emit(
        crowdActionsOrFailure.fold(
          (l) => const ProfileTabState(crowdActions: []),
          (r) => state.copyWith(crowdActions: r),
        ),
      );
    });
  }
}
