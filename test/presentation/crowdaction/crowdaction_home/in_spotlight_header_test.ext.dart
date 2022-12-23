part of 'in_spotlight_header_test.dart';

extension WidgetX on WidgetTester {
  Future<void> pumpInSpotLightHeader(SpotlightBloc spotlightBloc) async {
    await pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => spotlightBloc,
          child: Scaffold(
            body: InSpotLightHeader(),
          ),
        ),
      ),
    );
  }
}
