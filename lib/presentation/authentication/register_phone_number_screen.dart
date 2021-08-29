import 'dart:async';

import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:collaction_app/infrastructure/core/injection.dart';
import 'package:flutter/material.dart';

import 'verify_code_screen.dart';

class RegisterPhoneNumberPage extends StatefulWidget {
  const RegisterPhoneNumberPage({Key? key}) : super(key: key);

  @override
  _RegisterPhoneNumberPageState createState() =>
      _RegisterPhoneNumberPageState();
}

class _RegisterPhoneNumberPageState extends State<RegisterPhoneNumberPage> {
  final _userRepository = getIt<IUserRepository>();
  final _textEditingController = TextEditingController();
  StreamSubscription? _credentialStreamSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _credentialStreamSubscription?.cancel();
  }

  void _registerPhoneNumber(BuildContext context) {
    final phoneNumber = _textEditingController.text;
    _credentialStreamSubscription?.cancel();
    final credentialsStream = _userRepository.registerPhoneNumber(phoneNumber);
    _credentialStreamSubscription = credentialsStream.listen((credentials) {
      Navigator.push<SignInResult?>(
              context,
              MaterialPageRoute(
                  builder: (context) => const VerifyCodePage(),
                  settings: RouteSettings(arguments: credentialsStream)))
          .then((value) {
        if (value != null) {
          // Did complete sign in
          Navigator.pop(context);
        }
      });
    }, onError: (error) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${error.toString()}'),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Enter your phone number:'),
                TextField(
                  controller: _textEditingController,
                ),
                ElevatedButton(
                    onPressed: () {
                      _registerPhoneNumber(context);
                    },
                    child: const Text('Register')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
