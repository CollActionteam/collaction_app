import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/presentation/routes/app_routes.gr.dart';
import 'package:collaction_app/presentation/shared_widgets/rectangle_button.dart';
import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class VerifiedPage extends StatelessWidget {
  const VerifiedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tight(const Size(150, 150)),
              child: const RiveAnimation.asset(
                'assets/animations/verified.riv',
              ),
            ),
            const Text(
              'You are all set',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Text(
              /// TODO: Get user.name from ?Bloc
              '{user.name}',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Now go ahead and change the world one crowdaction at a time',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9),
              child: const RectangleButton(
                /// TODO: onTap callback to be clarified and set up
                text: 'Go to crowdaction',
              ),
            ),
            const TextButton(
              /// TODO: onPressed -> Send user to the main page.
              onPressed: null,
              child: Text(
                'Show me all crowdactions',
                style: TextStyle(
                  color: kAccentColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pushRoute(BuildContext context, PageRouteInfo route) {
    context.router.push(route);
  }
}
