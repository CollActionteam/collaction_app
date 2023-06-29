import 'package:collaction_app/application/auth/auth_bloc.dart';
import 'package:collaction_app/application/crowdaction/spotlight/spotlight_bloc.dart';
import 'package:collaction_app/application/user/profile/profile_bloc.dart';
import 'package:collaction_app/application/user/profile_tab/profile_tab_bloc.dart';
import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction_failures.dart';
import 'package:collaction_app/domain/profile/profile.dart';
import 'package:collaction_app/domain/profile/user_profile.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:collaction_app/presentation/core/collaction_icons.dart';
import 'package:collaction_app/presentation/home/home_screen.dart';
import 'package:collaction_app/presentation/profile/profile_screen.dart';
import 'package:collaction_app/presentation/routes/app_routes.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../application/auth/auth_bloc.mocks.dart';
import '../../test_helper.dart';
import '../../test_utilities.dart';

void main() {
  late final AppRouter appRouter;
  late final MockSettingsRepository settingsRepository;
  late final MockCrowdActionRepository crowdActionRepository;
  late final MockProfileRepository profileRepository;
  late final MockAvatarRepository avatarRepository;
  late ProfileTabBloc profileTabBloc;
  late SpotlightBloc spotlightBloc;
  late ProfileBloc profileBloc;
  late MockAuthBloc authBloc;

  setUpAll(() {
    appRouter = AppRouter();
    settingsRepository = MockSettingsRepository();
    crowdActionRepository = MockCrowdActionRepository();
    profileRepository = MockProfileRepository();
    avatarRepository = MockAvatarRepository();
    authBloc = MockAuthBloc();
    spotlightBloc = SpotlightBloc(crowdActionRepository);
    profileBloc = ProfileBloc(profileRepository, avatarRepository);
    profileTabBloc = ProfileTabBloc(crowdActionRepository);

    GetIt.I.registerSingleton<ProfileBloc>(profileBloc);
    GetIt.I.registerSingleton<ProfileTabBloc>(profileTabBloc);
    GetIt.I.registerSingleton<AuthBloc>(authBloc);
    GetIt.I.registerSingleton<SpotlightBloc>(spotlightBloc);
    GetIt.I.registerSingleton<ISettingsRepository>(settingsRepository);

    when(() => crowdActionRepository.getSpotlightCrowdActions()).thenAnswer(
        (invocation) => Future.value(left(CrowdActionFailure.serverError())));

    when(() => crowdActionRepository.getCrowdActionsForUser()).thenAnswer(
        (invocation) => Future.value(left(CrowdActionFailure.serverError())));
  });

  tearDownAll(() {
    GetIt.I.unregister<ProfileBloc>();
    GetIt.I.unregister<ProfileTabBloc>();
    GetIt.I.unregister<AuthBloc>();
    GetIt.I.unregister<SpotlightBloc>();
    GetIt.I.unregister<ISettingsRepository>();
  });

  tearDown(() {
    GetIt.I.unregister<ProfileBloc>();
    GetIt.I.unregister<ProfileTabBloc>();
    GetIt.I.unregister<SpotlightBloc>();

    profileBloc = ProfileBloc(profileRepository, avatarRepository);
    profileTabBloc = ProfileTabBloc(crowdActionRepository);
    spotlightBloc = SpotlightBloc(crowdActionRepository);

    GetIt.I.registerSingleton<ProfileBloc>(profileBloc);
    GetIt.I.registerSingleton<ProfileTabBloc>(profileTabBloc);
    GetIt.I.registerSingleton<SpotlightBloc>(spotlightBloc);
  });

  testWidgets('navigate to profile screen', (tester) async {
    when(() => settingsRepository.getWasUserOnboarded())
        .thenAnswer((_) => Future.value(true));

    await buildAndPump(
      tester: tester,
      widget: MultiBlocProvider(
        providers: [
          BlocProvider<ProfileBloc>(create: (context) => profileBloc),
          BlocProvider<ProfileTabBloc>(create: (context) => profileTabBloc),
        ],
        child: MaterialApp.router(
          color: Colors.white,
          title: 'CollAction',
          routerConfig: appRouter.router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);

    await tester.tap(find.byIcon(CollactionIcons.user));
    await tester.pumpAndSettle();

    expect(find.byType(UserProfilePage), findsOneWidget);
  });

  testWidgets('profile screen no user', (tester) async {
    await buildAndPump(
      tester: tester,
      widget: MultiBlocProvider(
        providers: [
          BlocProvider<ProfileBloc>(create: (context) => profileBloc),
          BlocProvider<ProfileTabBloc>(create: (context) => profileTabBloc),
        ],
        child: UserProfilePage(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(UserProfilePage), findsOneWidget);
  });

  testWidgets('profile screen w/ user', (tester) async {
    when(() => profileRepository.getUserProfile()).thenAnswer(
      (_) => Future.value(
        right(
          UserProfile(
            user: User.anonymous,
            profile: Profile(
              userId: 'userId',
              firstName: 'firstName',
              lastName: 'lastName',
              avatar: 'avatar',
              bio: 'bio',
            ),
          ),
        ),
      ),
    );

    await buildAndPump(
      tester: tester,
      widget: MultiBlocProvider(
        providers: [
          BlocProvider<ProfileBloc>(create: (context) => profileBloc),
          BlocProvider<ProfileTabBloc>(create: (context) => profileTabBloc),
        ],
        child: UserProfilePage(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(UserProfilePage), findsOneWidget);

    profileBloc.add(EditBio());
    await tester.pumpAndSettle();

    expect(profileBloc.state.isBioEditing, true);
  });
}
