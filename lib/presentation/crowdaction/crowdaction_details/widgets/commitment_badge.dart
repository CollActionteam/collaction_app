import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/collaction_icons.dart';
import '../../../themes/constants.dart';

class BadgesWidget extends StatelessWidget {
  static const String _heroBadgesTag = 'display-badges';

  const BadgesWidget({super.key});

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
            'The commitments you’ve chosen will give you the following badge',
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

  const _BadgesPopupCard({super.key});

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
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
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
                          'Different commitments give you a different set of points. These points correspond with badges.\nWhich one will you attain this month?',
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
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    backgroundColor: kSecondaryColor,
                    child: IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(CollactionIcons.cross),
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
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
    super.settings,
    super.fullscreenDialog = true,
  }) : _builder = builder;

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
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return _builder(context);
  }

  @override
  String get barrierLabel => 'Popup dialog open';
}
