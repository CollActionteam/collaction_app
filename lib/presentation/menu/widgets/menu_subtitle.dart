import 'package:flutter/material.dart';

import '../../themes/constants.dart';

class MenuSubtitle extends StatelessWidget {
  final String label;

  const MenuSubtitle({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 30, bottom: 10),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: kPrimaryColor300,
        ),
      ),
    );
  }
}
