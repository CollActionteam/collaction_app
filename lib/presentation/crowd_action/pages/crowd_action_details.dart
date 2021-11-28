import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/presentation/crowd_action/pages/widgets/bottom_navbar.dart';
import 'package:collaction_app/presentation/crowd_action/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../../domain/crowdaction/participant.dart';
import '../../routes/app_routes.gr.dart';
import '../../shared_widgets/participant_avatars.dart';
import '../../shared_widgets/pill_button.dart';
import '../../themes/constants.dart';
import '../utils/crowd_action.ext.dart';

class CrowdActionDetailsPage extends StatelessWidget {
  final CrowdAction crowdAction;
  const CrowdActionDetailsPage({
    Key? key,
    required this.crowdAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: PillButton(
        text: "Participate",
        onTap: () => _participate(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 310.0,
              pinned: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => context.router.pop(),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: Colors.white,
                      onPrimary: kAccentColor,
                    ),
                    child: const Icon(
                      Icons.chevron_left,
                      color: kPrimaryColor200,
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: kAccentColor,
                      onPrimary: kAccentColor,
                    ),
                    child: Image.asset('assets/images/icons/share.png'),
                  )
                  // Your widgets here
                ],
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  crowdAction.image ?? "",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: kAlmostTransparent,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      crowdAction.name,
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      spacing: 10.0,
                      children: crowdAction.toChips(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.router
                            .push(const CrowdActionParticipantsRoute());
                      },
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            // TODO - Add participants to crowdaction
                            SizedBox(
                              width: 100,
                              child: ParticipantAvatars(
                                participants: sampleParticipants,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                "Join ${sampleParticipants.title(crowdAction.numParticipants)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                        fontSize: 12, color: kPrimaryColor300),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      crowdAction.description,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                          height: 1.5),
                    )
                  ],
                ),
              ),
              const CommitmentsWidget(),
              const BadgesWidget(),
              const CrowdActionCreatedByWidget(),
            ],
          ),
        ),
      ),
    );
  }

  void _participate(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                width: 60.0,
                height: 3.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: kSecondaryTransparent,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Modal title",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Modal description. Nam quis nulla. Integer malesuada. In in enim a arcu imperdiet malesuada. Sed vel lectus. Donec odio urna, tempus molestie, porttitor ut, iaculis quis.",
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: kPrimaryColor400,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              PillButton(
                text: "Confirm Participation",
                onTap: () {},
                margin: EdgeInsets.zero,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CommitmentsWidget extends StatefulWidget {
  const CommitmentsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CommitmentsWidget> createState() => _CommitmentsWidgetState();
}

class _CommitmentsWidgetState extends State<CommitmentsWidget> {
  late int _selectedCommitment;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedCommitment = 0;
  }

  void handleClick(int inputCommitmentNumber) {
    setState(() {
      _selectedCommitment = _selectedCommitment == inputCommitmentNumber
          ? 0
          : inputCommitmentNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        color: kSecondaryColor,
        child: Column(
          children: [
            Text(
              'My commitments',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                'Short description about what the commitments are and how you can select/deselect them',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: kPrimaryColor300,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: CommitmentCard(
                onClickHandler: handleClick,
                selected: _selectedCommitment == 1,
                order: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: CommitmentCard(
                onClickHandler: handleClick,
                selected: _selectedCommitment == 2,
                order: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: CommitmentCard(
                onClickHandler: handleClick,
                selected: _selectedCommitment == 3,
                order: 3,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BadgesWidget extends StatelessWidget {
  static const String _heroBadgesTag = 'display-badges';

  const BadgesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: kAlmostTransparent,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 50),
            child: Hero(
              tag: _heroBadgesTag,
              child: Center(
                child: Material(
                  color: kAlmostTransparent,
                  borderRadius: BorderRadius.circular(20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        HeroBadgesDialogRoute(
                          builder: (context) {
                            return _BadgesPopupCard(key: key);
                          },
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'My badge',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 28,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Image.asset(
                            'assets/images/icons/tip.png',
                            color: kAccentColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Short description about what the badges are and how to achieve different levels',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPrimaryColor300,
            ),
          ),
          const SizedBox(height: 30),
          Column(
            children: [
              Image.asset(
                'assets/images/gold_badge.png',
                height: 100,
              ),
              const SizedBox(height: 5),
              const Text(
                'Jan, 2021',
                style: TextStyle(
                  color: kPrimaryColor300,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Title of the crowdaction',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Gold',
                style: TextStyle(
                  color: kPrimaryColor300,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ],
      ),
    );
  }
}

class CrowdActionCreatedByWidget extends StatelessWidget {
  const CrowdActionCreatedByWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "This CrowdAction was created by",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              //! TODO: Redirect to creator's profile
            },
            child: Row(
              children: const [
                CircleAvatar(
                  radius: 26,
                  foregroundImage: AssetImage('assets/images/user.png'),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Barbara",
                  style: TextStyle(
                    fontSize: 17,
                    color: kPrimaryColor400,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}

class CommitmentCard extends StatelessWidget {
  final bool selected;
  final Function? onClickHandler;
  final int order;
  const CommitmentCard(
      {Key? key, this.selected = false, this.onClickHandler, this.order = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: selected ? kAlmostTransparent : kSecondaryColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CommitmentAvatar(),
            const SizedBox(width: 10),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 200,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vegan Diet',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'This is a description of what this commitment is about.',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: kPrimaryColor300,
                        ),
                  )
                ],
              ),
            ),
            CommitmentCheckbox(
              selected: selected,
              onClickHandler: onClickHandler,
              order: order,
            ),
          ],
        ),
      ),
    );
  }
}

class CommitmentCheckbox extends StatelessWidget {
  final bool selected;
  final Function? onClickHandler;
  final int order;
  const CommitmentCheckbox(
      {Key? key, this.selected = false, this.onClickHandler, this.order = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: selected ? kPrimaryColor400 : kSecondaryColor,
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: selected ? kSecondaryColor : kPrimaryColor200,
        ),
      ),
      child: IconButton(
        onPressed: () {
          //! TODO: Select this commitment
          onClickHandler!(order);
        },
        icon: Image.asset(
          'assets/images/icons/check.png',
          color: kSecondaryColor,
          height: 30,
        ),
      ),
    );
  }
}

class _BadgesPopupCard extends StatelessWidget {
  static const _heroTag = 'display-badges';
  const _BadgesPopupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 250, 10, 10),
      child: Hero(
        tag: _heroTag,
        child: Material(
          color: kAlmostTransparent,
          borderRadius: BorderRadius.circular(10),
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Badges',
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28,
                                  ),
                        ),
                      ),
                      Container(
                        constraints: const BoxConstraints(
                          maxWidth: 300,
                        ),
                        child: Text(
                          'Short description about how you can earn different achievements/badges',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: kPrimaryColor300,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/gold_badge.png',
                                  height: 82,
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  'Gold',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: kPrimaryColor300,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 40),
                            const CommitmentAvatar(elevation: 5.0),
                            const SizedBox(width: 10),
                            const CommitmentAvatar(elevation: 5.0),
                          ],
                        ),
                      ),
                      // Expanded(child: Divider()),
                      const Divider(
                        thickness: 1,
                        indent: 25,
                        endIndent: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/silver_badge.png',
                                  height: 82,
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  'Silver',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: kPrimaryColor300,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 40),
                            const CommitmentAvatar(elevation: 5.0),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 25,
                        endIndent: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/bronze_badge.png',
                                  height: 82,
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  'Bronze',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: kPrimaryColor300,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 40),
                            const CommitmentAvatar(elevation: 5.0),
                          ],
                        ),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      // color: kSecondaryColor,
                      backgroundColor: kSecondaryColor,
                      child: IconButton(
                        onPressed: () => context.router.pop(),
                        icon: Image.asset('assets/images/icons/close_icon.png'),
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CommitmentAvatar extends StatelessWidget {
  final double elevation;
  const CommitmentAvatar({Key? key, this.elevation = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(40),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: kSecondaryColor,
        child: Image.asset('assets/images/diet.png'),
      ),
    );
  }
}

class HeroBadgesDialogRoute<T> extends PageRoute<T> {
  HeroBadgesDialogRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool fullscreenDialog = true,
  })  : _builder = builder,
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder _builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => kPrimaryColor.withOpacity(0.25);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  String get barrierLabel => 'Popup dialog open';
}
