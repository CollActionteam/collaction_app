import 'package:url_launcher/url_launcher.dart';

void launchUrl(
  String url, {
  bool useWebView = false,
}) =>
    canLaunch(url).then(
      (value) => launch(
        url,
        forceSafariVC: !useWebView,
        forceWebView: useWebView,
      ),
    );
