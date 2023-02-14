import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../presentation/utils/launch_url.dart';

class LegalNotice extends StatelessWidget {
  const LegalNotice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: context.colors.primaryColor300);
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "By clicking the button, you agree to CollAction’s ",
            style: textStyle,
          ),
          TextSpan(
            style: textStyle.copyWith(decoration: TextDecoration.underline),
            text: "terms of use",
            recognizer: TapGestureRecognizer()
              ..onTap = () => launchUrl(
                    "https://www.collaction.org/terms",
                    useWebView: true,
                    context: context,
                  ),
          ),
          TextSpan(
            style: textStyle,
            text: " and ",
          ),
          TextSpan(
            style: textStyle.copyWith(decoration: TextDecoration.underline),
            text: "privacy policy",
            recognizer: TapGestureRecognizer()
              ..onTap = () => launchUrl(
                    "https://www.collaction.org/privacy",
                    useWebView: true,
                    context: context,
                  ),
          ),
          TextSpan(
            style: textStyle,
            text: ".",
          ),
        ],
      ),
    );
  }
}
