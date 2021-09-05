import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/user_auth/auth_bloc.dart';
import '../../infrastructure/core/injection.dart';

class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({Key? key}) : super(key: key);

  @override
  _VerifyCodePageState createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final AuthBloc _authBloc = getIt<AuthBloc>();
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        state.maybeWhen(
            authError: (error) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Error: $error'),
              ));
            },
            verifying: (smsCode) {
              setState(() {
                _textEditingController.text = smsCode;
              });
            },
            orElse: () {});
      },
      builder: (context, state) {
        final isInputEnabled = state.maybeWhen<bool>(
            registeringPhoneNumber: () => false, orElse: () => true);
        return WillPopScope(
          onWillPop: () async {
            _authBloc.add(const AuthEvent.reset());
            return true;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Enter the number:'),
                      TextField(
                        controller: _textEditingController,
                        enabled: isInputEnabled,
                      ),
                      ElevatedButton(
                          onPressed: !isInputEnabled
                              ? null
                              : () => _authBloc.add(AuthEvent.verify(
                                  _textEditingController.text)),
                          child: const Text('Verify')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
