import 'package:collaction_app/presentation/shared_widgets/pill_button.dart';
import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareCollActionCard extends StatelessWidget {
  const ShareCollActionCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: kShadowColor,
            blurRadius: 4.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: kPrimaryColor400,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              "Share CollAction with\n your friends!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "CollAction is an application powered by the crowd the more the better",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: kSecondaryColor),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Image.asset("assets/images/share.png")),
            const SizedBox(
              height: 10,
            ),
            PillButton.icon(
              text: "Share CollAction",
              leading: const Icon(
                Icons.person_outline,
              ),
              // TODO - Get proper share message & title
              onTap: () => Share.share(
                'Share app title',
                subject: 'Share app details',
              ),
              margin: const EdgeInsets.symmetric(horizontal: 30),
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
