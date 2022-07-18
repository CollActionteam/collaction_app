import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../domain/user/user.dart';
import '../../routes/app_routes.gr.dart';
import '../../shared_widgets/pill_button.dart';
import '../../themes/constants.dart';

class UserProfileTab extends StatefulWidget {
  final User? user;
  const UserProfileTab({Key? key, this.user}) : super(key: key);

  @override
  State<UserProfileTab> createState() => _UserProfileTabState();
}

class _UserProfileTabState extends State<UserProfileTab>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        color: Colors.white,
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                height: 54,
                margin: const EdgeInsets.only(bottom: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: kAlmostTransparent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: TabBar(
                  tabs: [
                    Column(
                      children: const [
                        ImageIcon(
                          AssetImage(
                            'assets/images/badge.png',
                          ),
                        ),
                        SizedBox(height: 10),
                        _TabLabel(label: 'Badges'),
                      ],
                    ),
                    Column(
                      children: const [
                        ImageIcon(
                          AssetImage(
                            'assets/images/crowdactions.png',
                          ),
                        ),
                        SizedBox(height: 10),
                        _TabLabel(label: 'CrowdActions'),
                      ],
                    ),
                    Column(
                      children: const [
                        ImageIcon(
                          AssetImage(
                            'assets/images/commitments.png',
                          ),
                        ),
                        SizedBox(height: 10),
                        _TabLabel(label: 'Commitments'),
                      ],
                    )
                  ],
                  unselectedLabelColor: const Color(0xffacb3bf),
                  indicatorColor: Colors.transparent,
                  labelColor: kAccentColor,
                  controller: _tabController,
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    BadgesTab(user: widget.user),
                    CrowdActionsTab(user: widget.user),
                    CommitmentsTab(user: widget.user),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }
}

class _TabLabel extends StatelessWidget {
  final String label;
  const _TabLabel({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 11,
      ),
    );
  }
}

class BadgesTab extends StatelessWidget {
  final User? user;
  const BadgesTab({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Image.asset('assets/images/badges_tab_empty.png'),
            const SizedBox(height: 40),
            SignUpCTA(
              user: user,
              title: 'Unique badges based on your commitments',
            ),
          ],
        ),
      ),
    );
  }
}

class CrowdActionsTab extends StatelessWidget {
  final User? user;
  const CrowdActionsTab({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Image.asset('assets/images/crowdactions_tab_empty.png'),
            const SizedBox(height: 40),
            SignUpCTA(
              user: user,
              title: 'All CrowdActions you have participated in',
            ),
          ],
        ),
      ),
    );
  }
}

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

class SignUpCTA extends StatelessWidget {
  final User? user;
  final String? title;

  const SignUpCTA({
    Key? key,
    this.user,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            user != null
                ? (title != null
                    ? title!
                    : 'Unique content based on your activity')
                : 'Become part of the CollAction crowd',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 34,
              color: kPrimaryColor400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          if (user == null) ...[
            const Text(
              'Create an account to participate in \nCrowdActions and make waves with other \nlikeminded people!',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 17,
                color: kPrimaryColor300,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            PillButton(
              text: 'Create account or sign in',
              onTap: () {
                context.router.push(const AuthRoute());
              },
            ),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
