import 'dart:async';

import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:collaction_app/infrastructure/core/injection.dart';
import 'package:flutter/material.dart';

class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({Key? key}) : super(key: key);

  @override
  _VerifyCodePageState createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final _userRepository = getIt<IUserRepository>();
  final _textEditingController = TextEditingController();
  String? _verificationId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  void _verify(BuildContext context) {
    _userRepository
        .signIn(Credential(_verificationId, _textEditingController.text))
        .then((value) => Navigator.pop(context, value))
        .onError((error, stackTrace) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${error.toString()}'),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: cast_nullable_to_non_nullable
    (ModalRoute.of(context)!.settings.arguments as Stream<Credential>)
        .listen((credential) {
      _verificationId = credential.verificationId;
      if (credential.smsCode != null) {
        _textEditingController.text = credential.smsCode!;
        _verify(context);
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23.0),
            child: StreamBuilder<Credential>(
              // ignore: cast_nullable_to_non_nullable
              stream: ModalRoute.of(context)!.settings.arguments
                  as Stream<Credential>,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Enter the number:'),
                    TextField(
                      controller: _textEditingController,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _verify(context);
                        },
                        child: const Text('Verify')),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
