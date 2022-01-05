import 'package:flutter/material.dart';

import '../themes/constants.dart';

class CenteredLoadingIndicator extends StatelessWidget {
  final String label;
  const CenteredLoadingIndicator({
    Key? key,
    this.label = 'Loading CrowdActions',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  color: kAccentColor,
                  strokeWidth: 5.0,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                label,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
