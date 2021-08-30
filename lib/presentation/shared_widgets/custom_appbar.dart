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
      backgroundColor: title != null ? kSecondaryColor : Colors.transparent,
      elevation: 0.0,
      centerTitle: true,
      leading: ElevatedButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith(
            (states) => kAlmostTransparent,
          ),
          elevation: MaterialStateProperty.all<double?>(0.0),
          shape:
              MaterialStateProperty.all<OutlinedBorder?>(const CircleBorder()),
          backgroundColor: title != null
              ? MaterialStateProperty.all<Color?>(Colors.transparent)
              : MaterialStateProperty.all<Color?>(Colors.white),
        ),
        onPressed: () => context.router.pop(),
        child: Image.asset('assets/images/icons/back_icon.png'),
      ),
      title: Text(
        title ?? '',
        style: const TextStyle(color: kPrimaryColor),
      ),
    );
  }

  @override
  Size get preferredSize => Size(MediaQuery.of(_context).size.width, 55.0);
}
