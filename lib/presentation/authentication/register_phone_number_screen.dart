import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:collaction_app/infrastructure/core/injection.dart';
import 'package:collaction_app/presentation/routes/app_routes.gr.dart';
import 'package:flutter/material.dart';

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
  bool _isButtonDisabled = false;

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
      final router = context.router;
      router
          .push<SignInResult>(
              VerifyCodeRoute(credentialStream: credentialsStream))
          .then((signInResult) {
        if (signInResult != null) {
          // Did complete sign in
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('New user: ${signInResult.isNewUser}'),
          ));
          router.pop();
        }
      });
    }, onError: (error) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${error.toString()}'),
      ));
    }, onDone: () {
      setState(() {
        _isButtonDisabled = false;
      });
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
                    onPressed: _isButtonDisabled
                        ? null
                        : () {
                            _registerPhoneNumber(context);
                            setState(() {
                              _isButtonDisabled = true;
                            });
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
