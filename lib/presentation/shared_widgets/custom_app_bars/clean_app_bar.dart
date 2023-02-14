import 'package:flutter/material.dart';

import '../../../core/core.dart';

class CleanAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final Color? backgroundColor;
  final ElevatedButton? leading;
  final List<ElevatedButton>? actions;
  final double elevation;
  final TextStyle? titleTextStyle;

  const CleanAppBar({
    super.key,
    this.title = '',
    this.centerTitle = true,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.titleTextStyle,
    this.elevation = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith(
              (states) => context.colors.almostTransparent,
            ),
            elevation: MaterialStateProperty.all<double>(0.0),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              const CircleBorder(),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor ?? context.colors.secondaryColor,
        elevation: elevation,
        centerTitle: centerTitle,
        leading: leading,
        actions: actions,
        title: Text(title),
        titleTextStyle: titleTextStyle ??
            Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: context.colors.primaryColor),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
