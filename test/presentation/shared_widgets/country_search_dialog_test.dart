import 'package:collaction_app/presentation/shared_widgets/country_search_dialog.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import '../../test_helper.dart';

void main() {
  CountryDetails? countryDetails;
  void onCountrySelected(CountryDetails cd) => countryDetails = cd;

  group('CountrySearch test:', (() {
    testWidgets('render correctly with empty [TextField]',
        (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: CountrySearch(
          onCountrySelected: onCountrySelected,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CountrySearch), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(InkWell), findsAtLeastNWidgets(1));
      expect(
        (tester.firstWidget(find.byType(EditableText)) as EditableText)
            .controller
            .text,
        '',
      );
    });

    testWidgets(
        'search for a country (Nederland), '
        'and call onCountrySelected with the correct [CountryDetails]',
        (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: CountrySearch(
          onCountrySelected: onCountrySelected,
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Nederland');
      await tester.pumpAndSettle();
      expect(find.text('Nederland'), findsNWidgets(2));
      expect(find.byType(InkWell), findsOneWidget);
      await tester.tap(find.byType(InkWell));
      expect(countryDetails?.name, 'Nederland');
    });
  }));
}
