import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../themes/constants.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  final List<Map<String, String?>> settingsContents = [
    {
      'leading_icon': 'assets/images/icons/share.png',
      'title': 'Share Collaction',
      'url': 'https://www.collaction.org/',
      'trailing_icon': 'assets/images/arrow_fwd.png',
    },
    {
      'leading_icon': 'assets/images/icons/contact_us.png',
      'title': 'Contact Us',
      'url': 'https://www.collaction.org/',
      'trailing_icon': 'assets/images/arrow_fwd.png',
    },
    {
      'leading_icon': 'assets/images/icons/terms_and_cond.png',
      'title': 'Terms and Conditions',
      'url': 'https://www.collaction.org/',
      'trailing_icon': 'assets/images/arrow_fwd.png',
    },
    {
      'leading_icon': 'assets/images/icons/privacy_policy.png',
      'title': 'Privacy Policy',
      'url': 'https://www.collaction.org/',
      'trailing_icon': 'assets/images/arrow_fwd.png',
    },
    {
      'leading_icon': 'assets/images/icons/os_libraries.png',
      'title': 'Open Source Libraries',
      'url': 'https://www.collaction.org/',
      'trailing_icon': 'assets/images/redirecting.png',
    },
    {
      'leading_icon': 'assets/images/icons/logout.png',
      'title': 'Log Out',
      'url': 'https://www.collaction.org/',
      'trailing_icon': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          itemCount: 6,
          itemBuilder: (ctx, int ind) {
            final String title = settingsContents[ind]['title'].toString();
            final String leadingIcon =
                settingsContents[ind]['leading_icon'].toString();
            final String url = settingsContents[ind]['url'].toString();
            final String trailingIcon =
                settingsContents[ind]['trailing_icon'].toString();

            return ListTile(
              onTap: () async {
                // SettingsLayout is settings details page, can be made in next version.
                // context.router.push(const SettingsLayout());
                if (!await canLaunch(url)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Could not launch $url!! Please try again.'),
                    ),
                  );
                } else {
                  // ignore: avoid_print
                  print('launching....');
                  await launch(url);
                }
              },
              // context.router.push(SettingsDetails(
              //   title: title,
              //   url: url,
              // )),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              tileColor: kAlmostTransparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              leading: CircleAvatar(
                radius: 32.5,
                backgroundColor: kSecondaryColor,
                child: ImageIcon(
                  AssetImage(
                    leadingIcon,
                  ),
                  color: ind == 5 ? kErrorColor : kPrimaryColor300,
                ),
              ),
              title: Text(
                title,
              ),
              trailing: trailingIcon != ''
                  ? ImageIcon(
                      AssetImage(
                        trailingIcon,
                      ),
                      color: kPrimaryColor300,
                    )
                  : null,
            );
          },
          separatorBuilder: (ctx, int ind) => const SizedBox(
            height: 15,
          ),
        ),
      ),
    );
  }
}
