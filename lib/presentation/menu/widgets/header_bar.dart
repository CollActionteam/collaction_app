import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../themes/constants.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Menu",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: kPrimaryColor400,
          ),
        ),
        IconButton(
          onPressed: () {
            // TODO: Search bar functionality
          },
          icon: Icon(
            Ionicons.search,
            color: kPrimaryColor600,
            size: 26,
          ),
        ),
      ],
    );
  }
}
