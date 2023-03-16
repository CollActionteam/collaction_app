import 'package:flutter/material.dart';

import 'ca_menu_item.dart';
import 'menu_subtitle.dart';

class MenuCategory extends StatelessWidget {
  final String label;
  final List<CAMenuItem> items;

  const MenuCategory({
    super.key,
    required this.label,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MenuSubtitle(label: label),
        ...items,
      ],
    );
  }
}
