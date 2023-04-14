import 'package:flutter/material.dart';

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
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: kPrimaryColor600,
            size: 21.08,
          ),
        ),
      ],
    );
  }
}
