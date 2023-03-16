import 'package:flutter/material.dart';

import '../themes/constants.dart';
import 'widgets/contact_info.dart';
import 'widgets/personal_info.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kSecondaryColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  // TO DO: need to find proper back button icon
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text(
                      'Account information',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor400,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Column(
                  children: [
                    PersonalInformation(),
                    const SizedBox(height: 20),
                    ContactInformation(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
