import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_tab_event.dart';
part 'profile_tab_state.dart';
part 'profile_tab_bloc.freezed.dart';

class ProfileTabBloc extends Bloc<ProfileTabEvent, ProfileTabState> {
  ProfileTabBloc() : super(const _Initial()) {
    on<ProfileTabEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
