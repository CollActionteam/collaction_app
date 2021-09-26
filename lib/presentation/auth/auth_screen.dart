/*
 * TODO:
 * - Abstract into widgets --MOST IMPORTANT FOR MERGE
 * - New account flow --MOST IMPORTANT FOR MERGE
 * - Found account flow --CAN BE DONE IN SEPARATE TASK
 * - Not whitelisted number flow --CAN BE DONE IN SEPARATE TASK
 * - Invite friends flow --CAN BE DONE IN SEPARATE TASK
 */
import 'package:collaction_app/infrastructure/core/injection.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './pages/enter_username.dart';
import './pages/verification_code.dart';
import './pages/verify_phone.dart';
import '../../application/auth/auth_bloc.dart';
import '../shared_widgets/custom_app_bars/custom_appbar.dart';
import '../themes/constants.dart';
import '../utils/context.ext.dart';
import 'pages/profile_photo.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // All Pages
  final _pageController = PageController();
  double _currentPage = 0.0;
  late List<Widget> _pages;

  bool _displayDots = true;

  // Page One
  final GlobalKey<VerifyPhonePageState> _verifyPhoneKey = GlobalKey();

  // Page Two

  @override
  void initState() {
    super.initState();
    // All pages
    _pages = [
      VerifyPhonePage(key: _verifyPhoneKey),
      EnterVerificationCode(reset: _reset),
      const EnterUserName(),
      SelectProfilePhoto(
        onNext: _nextPage,
        onSkip: () => {},
      )
    ];

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
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
                  // TODO - Handle if is existing user
                }
              },
              verificationCompleted: (_) {},
              authError: (authError) {
                context.showErrorSnack(
                  authError.failure.map(
                    serverError: (_) => "Server Error",
                    invalidPhone: (_) => "Invalid Phone",
                    verificationFailed: (_) => "Verification Failed",
                    networkRequestFailed: (_) => "No Internet connection",
                    invalidSmsCode: (_) => "Invalid SMS Code",
                  ),
                );
              },
              usernameUpdateDone: (_) {
                _toPage(3);
                setState(() => _displayDots = false);
              },
              orElse: () {});
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: _currentPage == 0
              ? CustomAppBar(
                  context,
                  closable: true,
                )
              : AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 470.0,
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: _pages,
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
                    else
                      Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// Page Two
  void _reset() {
    _verifyPhoneKey.currentState?.reset();
    _pageController.animateTo(0.0,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void _nextPage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void _toPage(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}
