import 'package:flutter/material.dart';

import '../../themes/constants.dart';

class ScrollableAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final Color backgroundColor;
  final ElevatedButton? leading;
  final List<ElevatedButton>? actions;
  final TextStyle? titleTextStyle;
  final ScrollController pageScrollController;
  final double? elevation;
  final double minElevation;
  final double maxElevation;

  const ScrollableAppBar({
    super.key,
    this.title = '',
    this.centerTitle = true,
    this.backgroundColor = kSecondaryColor,
    this.titleTextStyle,
    this.leading,
    this.actions,
    this.elevation,
    this.minElevation = 0.0,
    this.maxElevation = 2.0,
    required this.pageScrollController,
  });

  @override
  ScrollableAppBarState createState() => ScrollableAppBarState();

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}

@visibleForTesting
class ScrollableAppBarState extends State<ScrollableAppBar> {
  final scrollController = ScrollController();

  late double currentElevation;

  @override
  void initState() {
    super.initState();

    currentElevation = widget.elevation ?? widget.minElevation;

    widget.pageScrollController.addListener(
      () {
        if (widget.pageScrollController.position.pixels <=
            scrollController.position.maxScrollExtent) {
          scrollController.jumpTo(widget.pageScrollController.position.pixels);
        }

        if (widget.pageScrollController.position.pixels >
                widget.pageScrollController.position.minScrollExtent &&
            widget.elevation == null &&
            currentElevation == widget.minElevation) {
          setState(() => currentElevation = widget.maxElevation);
        } else if (widget.pageScrollController.position.pixels ==
                widget.pageScrollController.position.minScrollExtent &&
            widget.elevation == null) {
          setState(() => currentElevation = widget.minElevation);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith(
              (states) => kAlmostTransparent,
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
        backgroundColor: widget.backgroundColor,
        elevation: currentElevation,
        centerTitle: widget.centerTitle,
        leading: widget.leading,
        actions: widget.actions,
        title: SizedBox(
          height: 50.0,
          child: SingleChildScrollView(
            controller: scrollController,
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 100, bottom: 13),
              child: Text(widget.title),
            ),
          ),
        ),
        titleTextStyle: widget.titleTextStyle ??
            Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: kPrimaryColor),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
