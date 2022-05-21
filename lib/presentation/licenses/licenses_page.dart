import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/collaction_icons.dart';
import '../shared_widgets/custom_app_bars/custom_appbar.dart';
import '../shared_widgets/no_ripple_behavior.dart';
import '../themes/constants.dart';
import 'oss_licenses.dart';

class LicensesPage extends StatelessWidget {
  const LicensesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: double.infinity,
        height: 52,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          onPressed: () =>
              launchUrl(Uri.parse('https://github.com/CollActionteam/collaction_app')),
          style: ElevatedButton.styleFrom(
            primary: kAccentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(52),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text("Want to contribute?"),
              SizedBox(
                width: 8,
              ),
              Icon(CollactionIcons.external_link)
            ],
          ),
        ),
      ),
      backgroundColor: kSecondaryColor,
      body: ScrollConfiguration(
        behavior: NoRippleBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Text(
                  "Open source libraries",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 32.0,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 35.0),
                const Text(
                  "The following sets forth attribution notices for third party software that may be contained in portions of the CollAction product. We thank the open source community for all of their contributions.",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 17.0,
                  ),
                ),
                ...ossLicenses.keys.map((e) => _licenseToWidget(e)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _licenseToWidget(String key) {
    final licenseData = ossLicenses[key];
    final description = licenseData["description"] as String?;
    final license = licenseData["license"] as String?;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 27),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            licenseData["name"] as String? ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17.0,
            ),
          ),
          const SizedBox(
            height: 27,
          ),
          Text(
            description ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 17.0,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            license ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 17.0,
            ),
          ),
        ],
      ),
    );
  }
}
