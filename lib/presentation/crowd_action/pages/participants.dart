import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../domain/crowdaction/participant.dart';
import '../../themes/constants.dart';

class CrowdActionParticipantsPage extends StatelessWidget {
  const CrowdActionParticipantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: kPrimaryColor200,
          ),
          onPressed: () {
            context.router.pop();
          },
        ),
        title: const Text(
          "Participants",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: kPrimaryColor400,
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final participant = participantsPageParticipants[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(participant.photo ?? ""),
              radius: 26,
            ),
            title: Text(
              participant.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(fontSize: 17, fontWeight: FontWeight.w300),
            ),
          );
        },
        itemCount: participantsPageParticipants.length,
      ),
    );
  }
}
