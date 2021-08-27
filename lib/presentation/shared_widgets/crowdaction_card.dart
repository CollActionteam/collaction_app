import 'package:flutter/material.dart';

import '../themes/constants.dart';

class CrowdActionCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final List<Widget> chips;
  final String? description;
  const CrowdActionCard({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.chips,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: kShadowColor,
            blurRadius: 4.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: kSecondaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 216,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imagePath),
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const SizedBox(width: 15.0),
                      Wrap(
                        spacing: 12.0,
                        children: chips,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Text(
                        title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor400),
                      ),
                    ],
                  ),
                ),
                if (description != null) ...[
                  const SizedBox(height: 18.0),
                  Text(
                    description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(color: kInactiveColor),
                  ),
                ],
                // TODO: Add participants widget
              ],
            ),
          ],
        ),
      ),
    );
  }
}
