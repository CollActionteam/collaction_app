import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:collaction_app/infrastructure/core/injection.dart';
import 'package:flutter/material.dart';

class VerifyCodePage extends StatefulWidget {
  final Stream<Credential> credentialStream;

  const VerifyCodePage({required this.credentialStream, Key? key})
      : super(key: key);

  @override
  _VerifyCodePageState createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  late final StreamSubscription _credentialStreamSubscription;

  final _userRepository = getIt<IUserRepository>();
  final _textEditingController = TextEditingController();
  String? _verificationId;

  @override
  void initState() {
    super.initState();
    _credentialStreamSubscription =
        widget.credentialStream.listen((credential) {
      if (credential.verificationId != null) {
        _verificationId = credential.verificationId;
      }
      if (credential.smsCode != null) {
        _textEditingController.text = credential.smsCode!;
      }
      if (_verificationId != null && credential.smsCode != null) {
        // TODO auto verify and remove the following debug print
        // FIXME this gets printed twice
        debugPrint(
            'TODO Ready to verify: code: ${credential.smsCode}, id: ${credential.verificationId}');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _credentialStreamSubscription.cancel();
  }

  void _verify(BuildContext context) {
    _userRepository
        .signIn(Credential(_verificationId, _textEditingController.text))
        .then((value) => context.router.pop<SignInResult>(value))
        .onError((error, stackTrace) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${error.toString()}'),
      ));
      return true;
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
            child: StreamBuilder<Credential>(
              stream: widget.credentialStream,
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
