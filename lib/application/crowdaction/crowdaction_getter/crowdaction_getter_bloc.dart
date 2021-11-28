import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../../domain/crowdaction/i_crowdaction_repository.dart';

part 'crowdaction_getter_bloc.freezed.dart';
part 'crowdaction_getter_event.dart';
part 'crowdaction_getter_state.dart';

@injectable
class CrowdActionGetterBloc
    extends Bloc<CrowdActionGetterEvent, CrowdActionGetterState> {
  final ICrowdActionRepository _crowdActionRepository;

  CrowdActionGetterBloc(this._crowdActionRepository)
      : super(const CrowdActionGetterState.initial());

  @override
  Stream<CrowdActionGetterState> mapEventToState(
    CrowdActionGetterEvent event,
  ) async* {
    yield* event.map(getMore: (event) async* {
      try {
        List<CrowdAction> response;
        if (event.amount != null && event.amount! > 0) {
          response = await _crowdActionRepository.getCrowdActions(
              amount: event.amount!);
        } else {
          response = await _crowdActionRepository.getCrowdActions();
        }
        if (response.isNotEmpty) {
          yield CrowdActionGetterState.fetched(response);
        } else {
          yield const CrowdActionGetterState.noCrowdActions();
        }
      } catch (e) {
        yield const CrowdActionGetterState
            .noCrowdActions(); // TODO: Consider implementing error state
      }
    });
  }
}
