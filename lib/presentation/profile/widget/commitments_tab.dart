import 'package:collaction_app/domain/user/user.dart';
import 'package:collaction_app/presentation/profile/widget/signup_cta.dart';
import 'package:flutter/material.dart';

class CommitmentsTab extends StatelessWidget {
  final User? user;
  const CommitmentsTab({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Image.asset('assets/images/commitments_tab_empty.png'),
            const SizedBox(height: 40),
            SignUpCTA(
              user: user,
              title: 'View your amazing commitments here',
            ),
          ],
        ),
      ),
    );
  }
}
