// TODO: This widget is only for debugging purposes.
// It should be removed in the future.

import 'package:flutter/material.dart';

import '../../../domain/user/i_user_repository.dart';
import '../../../domain/user/user.dart';
import '../../../infrastructure/core/injection.dart';

class CurrentUserStatusText extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CurrentUserStatusTextState();
}

class _CurrentUserStatusTextState extends State<CurrentUserStatusText> {
  late final IUserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _userRepository = getIt<IUserRepository>();
  }

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
      stream: _userRepository.observeUser(),
    );
  }
}
