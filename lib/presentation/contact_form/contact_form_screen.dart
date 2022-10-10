import 'package:flutter/material.dart';

import '../../presentation/contact_form/widgets/contact_form.dart';
import '../../presentation/shared_widgets/no_ripple_behavior.dart';
import '../shared_widgets/custom_app_bars/custom_appbar.dart';
import '../themes/constants.dart';

class ContactFormPage extends StatefulWidget {
  const ContactFormPage({super.key});

  @override
  ContactFormPageState createState() {
    return ContactFormPageState();
  }
}

class ContactFormPageState extends State<ContactFormPage> {
  late ScrollController _pageScrollController;

  @override
  void initState() {
    super.initState();
    _pageScrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const CustomAppBar(),
        backgroundColor: kSecondaryColor,
        body: SafeArea(
          child: ScrollConfiguration(
            behavior: NoRippleBehavior(),
            child: SingleChildScrollView(
              controller: _pageScrollController,
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: ContactForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
