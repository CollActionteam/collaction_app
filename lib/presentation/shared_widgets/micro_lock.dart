import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../core/collaction_icons.dart';

class MicroLock extends StatelessWidget {
  const MicroLock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: context.kTheme.primaryColor0!),
      ),
      child: Icon(
        CollactionIcons.lock,
        color: context.kTheme.primaryColor300,
        size: 15.0,
      ),
    );
  }
}
