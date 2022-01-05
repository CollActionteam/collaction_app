import 'package:collaction_app/presentation/core/collaction_icons.dart';
import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:collaction_app/presentation/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareCollactionListTile extends StatefulWidget {
  const ShareCollactionListTile({
    Key? key,
    String? shareText,
    String? shareEmailSubject,
  })  : _shareText = shareText,
        _shareEmailSubject = shareEmailSubject,
        super(key: key);

  final String? _shareText;
  final String? _shareEmailSubject;

  @override
  State<ShareCollactionListTile> createState() =>
      _ShareCollactionListTileState();
}

class _ShareCollactionListTileState extends State<ShareCollactionListTile> {
  late bool _isClicked;
  Future<void> _clickCallback() async {
    setState(() {
      _isClicked = true;
    });

    Share.share(
      widget._shareText ?? defaultShareText,
      subject: widget._shareEmailSubject ?? defaultShareEmailSubject,
    );
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isClicked = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _isClicked = false;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (bool focused) {
        setState(() {
          _isClicked = focused == false;
        });
      },
      child: ListTile(
        enabled: !_isClicked,
        onTap: _clickCallback,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        tileColor: kAlmostTransparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        leading: const CircleAvatar(
          radius: 32.5,
          backgroundColor: kSecondaryColor,
          child: Icon(
            CollactionIcons.share,
            color: kPrimaryColor300,
          ),
        ),
        title: const Text(
          'Share CollAction',
        ),
        trailing: const Icon(CollactionIcons.arrow_right),
      ),
    );
  }
}
