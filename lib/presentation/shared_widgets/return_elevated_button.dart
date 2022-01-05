import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

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
      onPressed: () => context.router.pop(),
      child: const Icon(
        CollactionIcons.left,
      ),
    );
