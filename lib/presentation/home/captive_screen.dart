import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../domain/core/i_settings_repository.dart';
import '../../infrastructure/core/injection.dart';
import '../core/collaction_icons.dart';
import '../routes/app_routes.gr.dart';

class CaptivePage extends StatefulWidget {
  const CaptivePage({Key? key}) : super(key: key);

  @override
  _CaptivePageState createState() => _CaptivePageState();
}

class _CaptivePageState extends State<CaptivePage> {
  @override
  void initState() {
    super.initState();
    // TODO check if user is auhtenticated for bottom button text
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('hey there'),
      ),
      // bottomNavigationBar: ,
    );
  }
}
