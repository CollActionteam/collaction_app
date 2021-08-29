import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:collaction_app/infrastructure/core/injection.dart';
import 'package:flutter/material.dart';

class CurrentUserStatusText extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CurrentUserStatusTextState();
}

class _CurrentUserStatusTextState extends State<CurrentUserStatusText> {
  final _userRepository = getIt<IUserRepository>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            final name = snapshot.data!.id;
            final number = snapshot.data!.phoneNumber ?? 'no phone number';
            return Text('Current user: $name ($number)');
          } else {
            return const Text('...');
          }
        },
        stream: _userRepository.observeUser());
  }
}
