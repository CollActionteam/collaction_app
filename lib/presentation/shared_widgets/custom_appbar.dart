import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../themes/constants.dart';

// TODO: Possibly separate into multiple App bars? (ScrollableAppBar, ElevatedAppBar, CleanAppBar)
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final BuildContext _context;
  final String? title;
  final bool elevated;
  final ScrollController? pageScrollController;
  const CustomAppBar(this._context,
      {Key? key, this.title, this.elevated = false, this.pageScrollController})
      : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size(MediaQuery.of(_context).size.width, 55.0);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late bool _scrollable;
  late ScrollController _scrollController;
  final double maxElevation = 2.0;
  double currentElevation = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollable = widget.elevated;
    _scrollController = ScrollController();

    currentElevation =
        widget.pageScrollController == null ? maxElevation : currentElevation;

    widget.pageScrollController?.addListener(() {
      if (widget.pageScrollController!.position.pixels <=
          _scrollController.position.maxScrollExtent) {
        _scrollController.jumpTo(widget.pageScrollController!.position.pixels);

        setState(() {
          currentElevation = (_scrollController.position.pixels /
                  _scrollController.position.maxScrollExtent) *
              maxElevation;
          currentElevation = _scrollController.position.pixels <=
                  _scrollController.position.minScrollExtent + 20.0
              ? 0.0
              : currentElevation;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kSecondaryColor,
      elevation: widget.elevated ? currentElevation : 0.0,
      centerTitle: true,
      leading: ElevatedButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith(
            (states) => kAlmostTransparent,
          ),
          elevation: MaterialStateProperty.all<double>(0.0),
          shape:
              MaterialStateProperty.all<OutlinedBorder>(const CircleBorder()),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        onPressed: () => context.router.pop(),
        child: Image.asset('assets/images/icons/back_icon.png'),
      ),
      title: _scrollable && widget.pageScrollController != null
          ? SizedBox(
              height: 50.0,
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 100, bottom: 13),
                  child: Text(
                    widget.title ?? '',
                    style: const TextStyle(color: kPrimaryColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          : Text(
              widget.title ?? '',
              style: const TextStyle(color: kPrimaryColor),
            ),
    );
  }
}
