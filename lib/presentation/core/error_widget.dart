import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final FlutterErrorDetails details;

  const ErrorScreen({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              Text(
                'Something went wrong!',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
              ),
              const SizedBox(height: 20),
              Text(details.exception.toString()),
              const SizedBox(height: 30),
              Text(details.stack.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
