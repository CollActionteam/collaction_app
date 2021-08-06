import 'package:flutter/material.dart';

import '../themes/constants.dart';

class CenteredLoadingIndicator extends StatelessWidget {
  const CenteredLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: const [
              SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  color: kIrisColor,
                  strokeWidth: 5.0,
                ),
              ),
              SizedBox(height: 25),
              Text('Loading CrowdActions', style: TextStyle(fontSize: 16.0)),
            ],
          ),
        ),
      ],
    );
  }
}
