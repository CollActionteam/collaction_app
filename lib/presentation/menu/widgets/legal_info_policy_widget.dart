
import 'package:flutter/material.dart';

import '../../themes/constants.dart';

class LegalInfoAndPoliciesWidget extends StatefulWidget {
  final onTap;
  final IconData iconWidget;
  final String label;

  const LegalInfoAndPoliciesWidget(
      {Key? key,
        required this.onTap,
        required this.iconWidget,
        required this.label})
      : super(key: key);

  @override
  State<LegalInfoAndPoliciesWidget> createState() =>
      _LegalInfoAndPoliciesWidgetState();
}

class _LegalInfoAndPoliciesWidgetState
    extends State<LegalInfoAndPoliciesWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 27.6),
      child: InkWell(
        onTap:(){
          widget.onTap();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.iconWidget,
              size: 20,
            ),
            SizedBox(
              width: 14,
            ),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: kPrimaryColor300,
              ),
            )
          ],
        ),
      ),
    );
  }
}
