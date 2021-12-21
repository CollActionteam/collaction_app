import 'package:flutter/material.dart';
import '../../presentation/themes/constants.dart';

class UserProfileTab extends StatefulWidget {
  const UserProfileTab({Key? key}) : super(key: key);

  @override
  State<UserProfileTab> createState() => _UserProfileTabState();
}

class _UserProfileTabState extends State<UserProfileTab>
    with TickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 54,
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
                      Text('Badges')
                    ],
                  ),
                  Column(children: const [
                    ImageIcon(
                      AssetImage(
                        'assets/images/crowdactions.png',
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Crowdactions')
                  ]),
                  Column(
                    children: const [
                      ImageIcon(
                        AssetImage(
                          'assets/images/commitments.png',
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Commitments')
                    ],
                  )
                ],
                unselectedLabelColor: const Color(0xffacb3bf),
                indicatorColor: Colors.transparent,
                labelColor: kAccentColor,
                controller: _tabController,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  Text('Badges'),
                  Text('Crowdactions'),
                  Text('Commitments'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
