import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/auth/auth_bloc.dart';
import 'package:collaction_app/application/user/avatar/avatar_bloc.dart';
import 'package:collaction_app/presentation/auth/widgets/profile_photo.dart';
import 'package:collaction_app/presentation/shared_widgets/photo_selector.dart';
import 'package:collaction_app/presentation/shared_widgets/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

import '../../application/auth/auth_bloc.mocks.dart';
import '../../application/user/avatar/avatar_bloc.mocks.dart';
import '../router.mocks.dart';
import '../shared_widgets/photo_selector_test.dart';

part 'profile_photo_test.ext.dart';

void main() {
  late GoRouter goRouter;

  late AvatarBloc avatarBloc;
  late AuthBloc authBloc;

  const MethodChannel imagePickerChannel =
      MethodChannel('plugins.flutter.io/image_picker');
  const MethodChannel cropImageChannel =
      MethodChannel('plugins.hunghd.vn/image_cropper');

  setUpAll(() {
    goRouter = RouteHelpers.setUpRouterStubs();

    // Avatar Bloc
    avatarBloc = MockAvatarBloc();
    when(() => avatarBloc.state).thenAnswer(
      (_) => AvatarState.initial(),
    );
    GetIt.I.registerSingleton<AvatarBloc>(avatarBloc);

    // Auth Bloc
    authBloc =  MockAuthBloc();
    when(() => authBloc.state).thenAnswer(
      (_) => AuthState.initial(),
    );
    GetIt.I.registerSingleton<AuthBloc>(authBloc);

    imagePickerChannel.setMockMethodCallHandler((MethodCall call) async {
      if (call.method == 'pickImage') {
        XFile? xFile = await getFileFromAssets('default_avatar.png');
        return xFile!.path;
      }
      return null;
    });

    cropImageChannel.setMockMethodCallHandler((MethodCall call) async {
      return call.arguments['source_path'];
    });

    registerFallbackValue(AuthEvent.updateProfilePhoto(File('')));
  });

  tearDownAll(() {
    GetIt.I.unregister<AvatarBloc>();
    GetIt.I.unregister<AuthBloc>();
  });

  group('SelectProfilePhoto tests:', () {
    testWidgets('can render', (WidgetTester tester) async {
      await tester.pumpSelectProfilePhoto(authBloc, goRouter, onSkip: () {});
      await tester.pumpAndSettle();

      expect(find.byType(SelectProfilePhoto), findsOneWidget);
      expect(
        tester.firstWidget<PillButton>(find.byType(PillButton)).isEnabled,
        false,
      );
      expect(
        tester.firstWidget<PillButton>(find.byType(PillButton)).isLoading,
        false,
      );
    });

    testWidgets('onSkip called when "Maybe later" pressed',
        (WidgetTester tester) async {
      bool onSkipCalled = false;
      await tester.pumpSelectProfilePhoto(
        authBloc,
        goRouter,
        onSkip: () => onSkipCalled = true,
      );
      await tester.tap(find.text('Maybe later'));
      await tester.pumpAndSettle();

      expect(onSkipCalled, true);
    });

    testWidgets('open PhotoSelection, select photo, adds event to AuthBloc',
        (WidgetTester tester) async {
      await tester.pumpSelectProfilePhoto(authBloc, goRouter, onSkip: () {});

      expect(
        tester.firstWidget<PillButton>(find.byType(PillButton)).isEnabled,
        false,
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(PhotoSelector), findsOneWidget);

      await tester.runAsync(() async {
        await tester.tap(find.byType(FloatingActionButton).at(1));
        await Future.delayed(Duration(seconds: 1));
        await tester.pumpAndSettle();
      });

      expect(
        tester.firstWidget<PillButton>(find.byType(PillButton)).isEnabled,
        true,
      );
      await tester.tap(find.byType(PillButton));
      await tester.pumpAndSettle();
      verify(() => authBloc.add(any())).called(1);
    });

    testWidgets('goRouter pops on uploadSuccess event',
        (WidgetTester tester) async {
      whenListen(
        avatarBloc,
        Stream.fromIterable([AvatarState.uploadSuccess()]),
      );
      await tester.pumpSelectProfilePhoto(authBloc, goRouter, onSkip: () {});
      verify(() => goRouter.pop()).called(1);
    });

    testWidgets('PillButton isLoading', (WidgetTester tester) async {
      when(() => authBloc.state).thenAnswer(
        (_) => AuthState.awaitingPhotoUpdate(),
      );
      await tester.pumpSelectProfilePhoto(authBloc, goRouter, onSkip: () {});
      expect(
        tester.firstWidget<PillButton>(find.byType(PillButton)).isLoading,
        true,
      );
    });
  });
}
