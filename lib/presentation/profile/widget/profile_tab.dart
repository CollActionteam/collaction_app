import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/user/profile_tab/profile_tab_bloc.dart';
import '../../../domain/user/user.dart';
import '../../themes/constants.dart';
import 'badges_tab.dart';
import 'commitments_tab.dart';
import 'crowdactions_tab.dart';

class UserProfileTab extends StatefulWidget {
  final User? user;
  const UserProfileTab({super.key, this.user});

  @override
  State<UserProfileTab> createState() => _UserProfileTabState();
}

class _UserProfileTabState extends State<UserProfileTab>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 1, length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileTabBloc>.value(
      value: BlocProvider.of<ProfileTabBloc>(context)
        ..add(FetchProfileTabInfo()),
      child: DefaultTabController(
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
              BlocBuilder<ProfileTabBloc, ProfileTabState>(
                builder: (context, state) {
                  return Expanded(
                    child: ColoredBox(
                      color: Colors.white,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          BadgesTab(user: widget.user),
                          CrowdActionsTab(
                            user: widget.user,
                            crowdActions: state.crowdActions,
                          ),
                          CommitmentsTab(
                            user: widget.user,
                            crowdActions: state.crowdActions,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
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
  const _TabLabel({required this.label});

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
