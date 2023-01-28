import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/auth/auth_bloc.dart';
import 'package:collaction_app/application/crowdaction/crowdaction_details/crowdaction_details_bloc.dart';
import 'package:collaction_app/application/participation/participation_bloc.dart';
import 'package:collaction_app/application/participation/top_participants/top_participants_bloc.dart';
import 'package:collaction_app/application/user/profile_tab/profile_tab_bloc.dart';
import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:collaction_app/presentation/crowdaction/crowdaction_details/crowdaction_details_screen.dart';
import 'package:collaction_app/presentation/home/widgets/password_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../application/auth/auth_bloc.mocks.dart';
import '../../../application/crowdaction/crowdaction_details/crowdaction_details_bloc.mocks.dart';
import '../../../application/participation/participation_bloc.mock.dart';
import '../../../application/participation/top_participants/top_participants_bloc.mocks.dart';
import '../../../application/user/profile_tab/profile_tab_bloc.mocks.dart';
import '../../../test_utilities.dart';

void main() {
  late final CrowdActionDetailsBloc crowdActionDetailsBloc;
  late final ProfileTabBloc profileTabBloc;
  late final ParticipationBloc participationBloc;
  late final TopParticipantsBloc topParticipantsBloc;
  late final AuthBloc authBloc;
  late final ISettingsRepository settingsRepository;

  final crowdAction = tCrowdaction;

  setUpAll(() {
    dotenv.testLoad(fileInput: tDotEnv);

    crowdActionDetailsBloc = MockCrowdActionDetailsBloc();
    GetIt.I.registerSingleton<CrowdActionDetailsBloc>(crowdActionDetailsBloc);
    when(() => crowdActionDetailsBloc.state).thenAnswer(
      (_) => CrowdActionDetailsState.initial(),
    );
    whenListen(
      crowdActionDetailsBloc,
      Stream.fromIterable(
        [
          CrowdActionDetailsState.initial(),
          CrowdActionDetailsState.loadSuccess(crowdAction),
        ],
      ),
    );

    profileTabBloc = MockProfileTabBloc();
    when(() => profileTabBloc.state).thenAnswer(
      (_) => ProfileTabState(crowdActions: [crowdAction]),
    );

    participationBloc = MockParticipationBloc();
    GetIt.I.registerSingleton<ParticipationBloc>(participationBloc);
    when(() => participationBloc.state).thenAnswer(
      (_) => ParticipationState.notParticipating(),
    );

    topParticipantsBloc = MockTopParticipantsBloc();
    GetIt.I.registerSingleton<TopParticipantsBloc>(topParticipantsBloc);
    when(() => topParticipantsBloc.state).thenAnswer(
      (_) => TopParticipantsState.initial(),
    );

    authBloc = MockAuthBloc();
    GetIt.I.registerSingleton<AuthBloc>(authBloc);
    when(() => authBloc.state).thenAnswer(
      (_) => AuthState.authenticated(User.anonymous),
    );

    settingsRepository = MockSettingsRepository();
    GetIt.I.registerSingleton<ISettingsRepository>(settingsRepository);
  });

  tearDownAll(() {
    GetIt.I.unregister<CrowdActionDetailsBloc>();
    GetIt.I.unregister<ParticipationBloc>();
    GetIt.I.unregister<TopParticipantsBloc>();
    GetIt.I.unregister<AuthBloc>();
    GetIt.I.unregister<ISettingsRepository>();
  });

  testWidgets(
      'should launch [PasswordModal] '
      'when crowdaction is not in access list', (tester) async {
    when(() => settingsRepository.getCrowdActionAccessList()).thenAnswer(
      (_) async => [],
    );
    when(
      () => settingsRepository.addCrowdActionAccess(
        crowdActionId: crowdAction.id,
      ),
    ).thenAnswer((_) async {});

    await tester.pumpCrowdActionsDetailPage(
      crowdAction: crowdAction,
      profileTabBloc: profileTabBloc,
    );

    await tester.pump();

    final findPasswordModal = find.byType(PasswordModal);
    expect(findPasswordModal, findsOneWidget);
  });

  testWidgets(
      'should not launch [PasswordModal] '
      'when crowdaction is in access list', (tester) async {
    when(() => settingsRepository.getCrowdActionAccessList()).thenAnswer(
      (_) async => [crowdAction.id],
    );

    await tester.pumpCrowdActionsDetailPage(
      crowdAction: crowdAction,
      profileTabBloc: profileTabBloc,
    );

    await tester.pump();

    expect(find.byType(PasswordModal), findsNothing);
  });
}

extension WidgetTesterX on WidgetTester {
  Future<void> pumpCrowdActionsDetailPage({
    required CrowdAction crowdAction,
    required ProfileTabBloc profileTabBloc,
  }) async {
    await pumpWidget(
      BlocProvider.value(
        value: profileTabBloc,
        child: MaterialApp(
          home: Scaffold(
            body: CrowdActionDetailsPage(
              crowdAction: crowdAction,
            ),
          ),
        ),
      ),
    );
  }
}
