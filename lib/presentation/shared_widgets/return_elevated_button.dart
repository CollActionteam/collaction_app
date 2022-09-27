import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/collaction_icons.dart';
import '../themes/constants.dart';

ElevatedButton returnElevatedButton(BuildContext context) => ElevatedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith(
          (states) => kAlmostTransparent,
        ),
        elevation: MaterialStateProperty.all<double>(0.0),
        shape: MaterialStateProperty.all<OutlinedBorder>(const CircleBorder()),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      onPressed: () => context.pop(),
      child: const Icon(
        CollactionIcons.left,
      ),
    );
