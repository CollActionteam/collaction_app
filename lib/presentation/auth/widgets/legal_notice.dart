import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalNotice extends StatelessWidget {
  const LegalNotice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: kPrimaryColor300);
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          const TextSpan(
            text: "By clicking the next button, you agree to CollAction’s ",
            style: textStyle,
          ),
          TextSpan(
            style: textStyle.copyWith(decoration: TextDecoration.underline),
            text: "terms & conditions",
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                const url = "https://www.collaction.org/terms";
                if (await canLaunch(url)) {
                  await launch(
                    url,
                    forceSafariVC: false,
                  );
                }
              },
          ),
          const TextSpan(
            style: textStyle,
            text: " and to our ",
          ),
          TextSpan(
            style: textStyle.copyWith(decoration: TextDecoration.underline),
            text: "privacy policy",
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                const url = "https://www.collaction.org/privacy";
                if (await canLaunch(url)) {
                  await launch(
                    url,
                    forceSafariVC: false,
                  );
                }
              },
          ),
          const TextSpan(
            style: textStyle,
            text: ".",
          ),
        ],
      ),
    );
  }
}
