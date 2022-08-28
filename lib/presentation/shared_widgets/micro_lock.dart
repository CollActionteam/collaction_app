import 'package:flutter/material.dart';

import '../core/collaction_icons.dart';
import '../themes/constants.dart';

class MicroLock extends StatelessWidget {
  const MicroLock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: kPrimaryColor0),
      ),
      child: const Icon(
        CollactionIcons.lock,
        color: kPrimaryColor300,
        size: 15.0,
      ),
    );
  }
}
