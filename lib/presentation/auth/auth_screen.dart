import 'package:auto_route/auto_route.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/auth/auth_bloc.dart';
import '../../application/auth/username_bloc.dart';
import '../../infrastructure/core/injection.dart';
import '../routes/app_routes.gr.dart';
import '../shared_widgets/custom_app_bars/custom_appbar.dart';
import '../themes/constants.dart';
import '../utils/context.ext.dart';
import 'widgets/enter_username.dart';
import 'widgets/profile_photo.dart';
import 'widgets/verification_code.dart';
import 'widgets/verify_phone.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _pageController = PageController();
  double _currentPage = 0.0;
  bool _displayDots = true;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(
      () => setState(() => _currentPage = _pageController.page!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeMap(
            smsCodeSent: (_) => _toPage(1),
            loggedIn: (loggedInState) {
              if (loggedInState.isNewUser) {
                _toPage(2);
              } else {
                _authDone(context);
              }
            },
            authError: (authError) => context.showErrorSnack(
              authError.failure.map(
                serverError: (_) => "Server Error",
                invalidPhone: (_) => "Invalid Phone",
                verificationFailed: (_) => "Verification Failed",
                networkRequestFailed: (_) => "No Internet connection",
                invalidSmsCode: (_) => "Invalid SMS Code",
              ),
            ),
            // usernameUpdateDone: (_) {
            //   _toPage(3);
            //   setState(() => _displayDots = false);
            // },
            photoUpdateDone: (_) => _authDone(context),
            orElse: () {},
          );
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: _currentPage == 0
              ? const CustomAppBar(closable: true)
              : AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 520.0,
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          const VerifyPhonePage(),
                          const EnterVerificationCode(),
                          const EnterUserName(),
                          SelectProfilePhoto(onSkip: () => _authDone(context))
                        ],
                      ),
                    ),
                    if (_displayDots)
                      DotsIndicator(
                        position: _currentPage % 3,
                        dotsCount: 3,
                        decorator: const DotsDecorator(
                          activeColor: kAccentColor,
                          color: Color(0xFFCCCCCC),
                          size: Size(12.0, 12.0),
                          activeSize: Size(12.0, 12.0),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _authDone(BuildContext context) =>
      context.router.replaceAll([const VerifiedRoute()]);

  void _toPage(int page) => _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
}
