import 'package:flutter/material.dart';

import '../../../shared_widgets/custom_app_bars/clean_app_bar.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  late ScrollController _pageScrollController;

  @override
  void initState() {
    super.initState();
    _pageScrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CleanAppBar(
        title: "Account Information",
        titleTextStyle: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
