import 'package:flutter/material.dart';

import '../../core/core.dart';

class CenteredLoadingIndicator extends StatelessWidget {
  final String label;
  const CenteredLoadingIndicator({
    super.key,
    this.label = 'Loading CrowdActions',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  color: context.colors.accentColor,
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
