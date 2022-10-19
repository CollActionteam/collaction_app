import 'package:flutter/material.dart';
import '../../themes/constants.dart';

class SettingsListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Function() onTap;
  final IconData? trailingIcon;

  const SettingsListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor = kPrimaryColor300,
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
      tileColor: kAlmostTransparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      leading: CircleAvatar(
        radius: 32.5,
        backgroundColor: kSecondaryColor,
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: Text(title),
      trailing: trailingIcon != null ? Icon(trailingIcon) : null,
    );
  }
}
