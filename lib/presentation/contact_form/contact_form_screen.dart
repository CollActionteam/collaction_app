import 'package:flutter/material.dart';

import '../../presentation/contact_form/widgets/contact_form.dart';
import '../../presentation/shared_widgets/no_ripple_behavior.dart';
import '../shared_widgets/custom_app_bars/custom_appbar.dart';

class ContactFormPage extends StatefulWidget {
  const ContactFormPage({Key? key}) : super(key: key);

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
        appBar: CustomAppBar(context),
        body: ScrollConfiguration(
          behavior: NoRippleBehavior(),
          child: SingleChildScrollView(
            controller: _pageScrollController,
            child: const ContactForm(),
          ),
        ),
      ),
    );
  }
}
