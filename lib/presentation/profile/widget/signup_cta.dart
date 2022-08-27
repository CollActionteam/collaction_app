import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:collaction_app/presentation/routes/app_routes.gr.dart';
import 'package:collaction_app/presentation/shared_widgets/pill_button.dart';
import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:flutter/material.dart';

class SignUpCTA extends StatelessWidget {
  final User? user;
  final String? title;

  const SignUpCTA({
    Key? key,
    this.user,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            user != null
                ? (title != null
                    ? title!
                    : 'Unique content based on your activity')
                : 'Become part of the CollAction crowd',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 34,
              color: kPrimaryColor400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          if (user == null) ...[
            const Text(
              'Create an account to participate in \nCrowdActions and make waves with other \nlikeminded people!',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 17,
                color: kPrimaryColor300,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            PillButton(
              text: 'Create account or sign in',
              onTap: () {
                context.router.push(const AuthRoute());
              },
            ),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
