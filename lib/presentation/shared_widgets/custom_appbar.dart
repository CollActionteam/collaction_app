import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../themes/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext _context;
  final String? title;
  const CustomAppBar(this._context, {Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kSecondaryColor,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => context.router.pop(),
        child: Image.asset('assets/images/icons/back_icon.png'),
      ),
      title: Text(
        title ?? '',
        style:
            const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w700),
      ),
    );
  }

  @override
  Size get preferredSize => Size(MediaQuery.of(_context).size.width, 55.0);
}
