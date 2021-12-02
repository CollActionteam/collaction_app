import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../domain/user/i_user_repository.dart';
import '../../../domain/user/user.dart';
import '../../../infrastructure/core/injection.dart';
import '../../../presentation/routes/app_routes.gr.dart';
import 'accent_chip.dart';

class SignUpChip extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpChipState();
}

class _SignUpChipState extends State<SignUpChip> {
  final _userRepository = getIt<IUserRepository>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return const SizedBox();
          } else {
            return GestureDetector(
              onTap: () => context.router.push(const AuthRoute()),
              child: const AccentChip(
                text: "Sign up now",
                leading: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            );
          }
        },
        stream: _userRepository.observeUser());
  }
}
