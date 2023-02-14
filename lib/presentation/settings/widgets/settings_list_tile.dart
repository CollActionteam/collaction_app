import 'package:flutter/material.dart';

import '../../../core/core.dart';

class SettingsListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? iconColor;
  final Function() onTap;
  final IconData? trailingIcon;

  const SettingsListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      tileColor: context.colors.almostTransparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      leading: CircleAvatar(
        radius: 32.5,
        backgroundColor: context.colors.secondaryColor,
        child: Icon(
          icon,
          color: iconColor ?? context.colors.primaryColor300,
        ),
      ),
      title: Text(title),
      trailing: trailingIcon != null ? Icon(trailingIcon) : null,
    );
  }
}
