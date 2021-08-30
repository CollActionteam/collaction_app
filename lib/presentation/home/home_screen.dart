import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/presentation/authentication/current_user_status_text.dart';
import 'package:flutter/material.dart';

import '../routes/app_routes.gr.dart';
import '../themes/constants.dart';
import 'widgets/crowdaction_carousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 23.0, horizontal: 23.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Upcoming crowdactions',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18.0),
                          ),
                          TextButton(
                            onPressed: () => context.router
                                .push(const CrowdActionBrowseRoute()),
                            child: const Text(
                              'View all',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: kIrisColor),
                            ),
                          ),
                        ],
                      ),
                      const CrowdActionCarousel(),
                      ElevatedButton(
                        onPressed: () {
                          context.router.push(const ContactFormRoute());
                        },
                        child:
                            const Text('Give feedback or start crowd action'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.router.push(const ComponentsDemoRoute());
                        },
                        child: const Text('UI Components Demo Page'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.router.push(const RegisterPhoneNumberRoute());
                        },
                        child: const Text('Register'),
                      ),
                      CurrentUserStatusText()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
