import 'package:collaction_app/application/auth/auth_bloc.dart';
import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:collaction_app/presentation/core/app_widget.dart';
import 'package:collaction_app/presentation/routes/app_routes.dart';
import 'package:flutter_test/flutter_test.dart';

import 'application/auth/auth_bloc.mocks.dart';
import 'test_utilities.dart';

void main() {
  late AppRouter appRouter;
  late AuthBloc authBloc;
  late ISettingsRepository settingsRepo;

  setUpAll(() {
    authBloc = MockAuthBloc();
    settingsRepo = MockSettingsRepository();
    appRouter = AppRouter(authBloc: authBloc, settingsRepo: settingsRepo);
  });

  testWidgets('Can render AppWidget', (WidgetTester tester) async {
    await tester.pumpWidget(AppWidget(
      appRouter: appRouter,
    ));

    expect(find.byType(AppWidget), findsOneWidget);
  });
}
