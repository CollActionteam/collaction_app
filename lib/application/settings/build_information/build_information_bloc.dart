import 'package:bloc/bloc.dart';
import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:collaction_app/domain/settings/build_information.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'build_information_event.dart';
part 'build_information_state.dart';
part 'build_information_bloc.freezed.dart';

@injectable
class BuildInformationBloc
    extends Bloc<BuildInformationEvent, BuildInformationState> {
  final ISettingsRepository _settingsRepository;

  BuildInformationBloc(this._settingsRepository)
      : super(const BuildInformationState.loading()) {
    on<BuildInformationEvent>((event, emit) async {
      await event.when(
        fetch: () async {
          emit(const BuildInformationState.loading());

          final buildInfo = await _settingsRepository.getBuildInformation();
          emit(BuildInformationState.fetched(buildInfo));
        },
      );
    });
  }
}
