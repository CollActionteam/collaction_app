import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../shared_widgets/pill_button.dart';
import '../../../utils/strings.dart';

class ShareCollactionButton extends StatefulWidget {
  const ShareCollactionButton({
    Key? key,
    String? shareText,
    String? shareEmailSubject,
  })  : _shareText = shareText,
        _shareEmailSubject = shareEmailSubject,
        super(key: key);

  final String? _shareText;
  final String? _shareEmailSubject;

  @override
  State<ShareCollactionButton> createState() => _ShareCollactionButtonState();
}

class _ShareCollactionButtonState extends State<ShareCollactionButton> {
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
      child: PillButton(
        text: "Share CollAction",
        isEnabled: !_isClicked,
        onTap: _clickCallback,
        margin: const EdgeInsets.symmetric(horizontal: 30),
      ),
    );
  }
}
