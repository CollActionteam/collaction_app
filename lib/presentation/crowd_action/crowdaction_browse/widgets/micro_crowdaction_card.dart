import 'package:flutter/material.dart';

import '../../../../domain/crowdaction/crowdaction.dart';
import '../../../themes/constants.dart';

class MicroCrowdActionCard extends StatelessWidget {
  final CrowdAction crowdAction;
  const MicroCrowdActionCard(this.crowdAction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 11.5),
      child: Container(
        decoration: BoxDecoration(
          color: kAlmostTransparent,
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: 115.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: ClipRect(
                clipBehavior: Clip.antiAlias,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 90.0,
                      width: 90.0,
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        crowdAction.name,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 14.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
