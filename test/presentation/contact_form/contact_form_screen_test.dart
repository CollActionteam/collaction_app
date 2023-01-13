import 'package:collaction_app/application/contact_form/contact_form_bloc.dart';
import 'package:collaction_app/presentation/contact_form/contact_form_screen.dart';
import 'package:collaction_app/presentation/contact_form/widgets/contact_form.dart';
import 'package:collaction_app/presentation/shared_widgets/custom_app_bars/custom_appbar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../application/contact_form/contact_form_bloc.mocks.dart';
import '../../test_helper.dart';

void main() {
  late ContactFormBloc contactFormBloc;

  setUpAll(() {
    // Contact Form Bloc
    contactFormBloc = MockContactFormBloc();
    when(() => contactFormBloc.state).thenAnswer(
      (_) => ContactFormState.initial(),
    );
    GetIt.I.registerSingleton<ContactFormBloc>(contactFormBloc);
  });

  tearDownAll(() {
    GetIt.I.unregister<ContactFormBloc>();
  });
  group('ContactFormPage tests:', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: ContactFormPage());
      await tester.pumpAndSettle();

      expect(find.byType(CustomAppBar), findsOneWidget);
      expect(find.byType(ContactForm), findsOneWidget);
    });
  });
}
