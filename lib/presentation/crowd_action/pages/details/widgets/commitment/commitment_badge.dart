import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/presentation/core/collaction_icons.dart';
import 'package:flutter/material.dart';

import '../../../../../themes/constants.dart';
import 'commitment_avatar.dart';

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
                        children: const [
                          Text(
                            'My badge',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 28,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            CollactionIcons.question,
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
                        icon: Icon(
                          CollactionIcons.cross,
                          color: kPrimaryColor300,
                        ),
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
