import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/collaction_icons.dart';
import '../../themes/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext _context;
  final String title;
  final bool closable;

  const CustomAppBar(
    this._context, {
    Key? key,
    this.title = "",
    this.closable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kSecondaryColor,
      elevation: 0.0,
      centerTitle: true,
      leading: !closable
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => context.router.pop(),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  primary: Colors.white,
                  onPrimary: kAccentColor,
                  elevation: 4,
                ),
                child: const Icon(
                  CollactionIcons.left,
                ),
              ),
            )
          : null,
      actions: [
        if (closable)
          GestureDetector(
            onTap: () => context.router.pop(),
            child: const Icon(CollactionIcons.cross),
          ),
      ],
      title: Text(title, style: const TextStyle(color: kPrimaryColor)),
    );
  }

  @override
  Size get preferredSize => Size(MediaQuery.of(_context).size.width, 55.0);
}
