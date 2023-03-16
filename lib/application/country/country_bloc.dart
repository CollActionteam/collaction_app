import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/core/location.dart';
import '../../domain/user/i_profile_repository.dart';

part 'country_event.dart';
part 'country_state.dart';
part 'country_bloc.freezed.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final IProfileRepository profileRepository;
  CountryBloc(this.profileRepository) : super(_Initial()) {
    on<CountryEvent>((event, emit) async {
      await event.when(
        updateCountry: (countryName, countryCode) async {
          emit(const CountryState.updateInProgress());
          final unitOrFailure = await profileRepository.updateCountry(
            location: Location(code: countryCode, name: countryName),
          );
          emit(
            await unitOrFailure.fold(
              (failure) => const CountryState.updateFailure(),
              (_) => CountryState.updateSuccess(),
            ),
          );
        },
      );
    });
  }
}
