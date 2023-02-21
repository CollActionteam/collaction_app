import 'package:flutter/material.dart';

import '../../../shared_widgets/custom_app_bars/clean_app_bar.dart';

import '../../../themes/constants.dart';
import 'widgets/contact_info.dart';
import 'widgets/personal_info.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CleanAppBar(
        title: "Account information",
        titleTextStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
            fontSize: 28,
            fontFamily: 'Rubik'),
      ),
      backgroundColor: kSecondaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PersonalInformation(),
            ContactInformation(),
          ],
        ),
      ),
    );
  }
}
