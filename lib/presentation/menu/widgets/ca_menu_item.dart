import 'package:flutter/material.dart';

import '../../themes/constants.dart';

class CAMenuItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final String? description;
  final VoidCallback onTap;

  const CAMenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 54) +
            const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: description == null
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            icon,
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kPrimaryColor300,
                    ),
                  ),
                  if (description != null) ...[
                    SizedBox(height: 5),
                    Text(
                      description!,
                      style: TextStyle(
                        fontSize: 12,
                        color: kPrimaryColor300,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
