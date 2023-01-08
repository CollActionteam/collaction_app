import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'collaction_icons.dart';

class IconUtil {
  static IconData fromString(String iconName) {
    return ioniconsMapping[iconName] != null
        ? int.tryParse(ioniconsMapping[iconName]!) != null
            ? IoniconsData(int.tryParse(ioniconsMapping[iconName]!)!)
            : CollactionIcons.collaction
        : CollactionIcons.collaction;
  }
}
