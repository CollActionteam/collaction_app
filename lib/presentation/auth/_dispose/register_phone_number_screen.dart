import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/auth_bloc.dart';
import '../../../infrastructure/core/injection.dart';

class RegisterPhoneNumberPage extends StatefulWidget {
  const RegisterPhoneNumberPage({Key? key}) : super(key: key);

  @override
  _RegisterPhoneNumberPageState createState() =>
      _RegisterPhoneNumberPageState();
}

class _RegisterPhoneNumberPageState extends State<RegisterPhoneNumberPage> {
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
        state.maybeMap(
            awaitingVerification: (_) {
              // context.router.push(const VerifyCodeRoute());
            },
            loggedIn: (result) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('New user: ${result.isNewUser}'),
              ));
              context.router.popUntilRoot();
            },
            authError: (error) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Error: ${error.error}'),
              ));
            },
            orElse: () {});
      },
      builder: (context, state) {
        final isInputEnabled = state.maybeWhen<bool>(
            registeringPhoneNumber: () => false, orElse: () => true);
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
                        enabled: isInputEnabled,
                      ),
                      ElevatedButton(
                          onPressed: !isInputEnabled
                              ? null
                              : () => _authBloc.add(
                                  AuthEvent.registerPhoneNumber(
                                      _textEditingController.text)),
                          child: const Text('Register')),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
