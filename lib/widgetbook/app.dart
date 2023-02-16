import '../presentation/menu_tabbar/widgets/account_info_screen/account_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@WidgetbookApp.material(name: 'CollAction Widgetbook')
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AccountInfoScreen(),
    );
  }
}
