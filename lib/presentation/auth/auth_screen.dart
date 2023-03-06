import 'package:auto_route/auto_route.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/auth/auth_bloc.dart';
import '../../application/user/profile/profile_bloc.dart';
import '../../domain/auth/auth_failures.dart' as $auth_failure;
import '../routes/app_routes.gr.dart';
import '../shared_widgets/custom_app_bars/custom_appbar.dart';
import '../themes/constants.dart';
import '../utils/context.ext.dart';
import 'widgets/enter_username.dart';
import 'widgets/profile_photo.dart';
import 'widgets/verification_code.dart';
import 'widgets/verify_phone.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  final _pageController = PageController();
  double _currentPage = 0.0;
  bool _displayDots = true;

  String? fullName;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(
      () => setState(() => _currentPage = _pageController.page!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SmsCodeSent) {
          _toPage(1);
        } else if (state is LoggedIn) {
          if (state.isNewUser) {
            // TODO: We need to improve this flow on the backend - this makes sure profile is created
            BlocProvider.of<ProfileBloc>(context).add(GetUserProfile());
            _toPage(2);
          } else {
            _authDone(context);
          }
        } else if (state is AuthError) {
          String message = 'Error';

          if (state.failure is $auth_failure.ServerError) {
            message = "Server Error";
          } else if (state.failure is $auth_failure.NetworkRequestFailed) {
            message = "No Internet connection";
          } else if (state.failure is $auth_failure.InvalidPhone) {
            message = "Invalid Phone";
          } else if (state.failure is $auth_failure.InvalidSmsCode) {
            message = "Invalid SMS Code";
          } else if (state.failure is $auth_failure.VerificationFailed) {
            message = "Verification Failed";
          }

          context.showErrorSnack(message);
        } else if (state is ProfilePhotoUpdateDone) {
          _authDone(context);
        }
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
                        EnterUserName(
                          onDone: (fName) {
                            _toPage(3);

                            setState(() {
                              _displayDots = false;
                              fullName = fName;
                            });
                          },
                        ),
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
