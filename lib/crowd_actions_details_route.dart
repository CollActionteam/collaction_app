import 'package:collaction_app/models/crowd_action_model.dart';
import 'package:flutter/material.dart';

/// Route displaying more information of a specific selected Collaction
class CrowdActionDetailsRoute extends StatefulWidget {
  final CrowdActionModel model;

  const CrowdActionDetailsRoute({Key? key, required this.model})
      : super(key: key);

  @override
  _ActionDetailScreenState createState() => _ActionDetailScreenState();
}

class _ActionDetailScreenState extends State<CrowdActionDetailsRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(widget.model.title ?? 'No title'),
            Text(widget.model.subtitle ?? 'No subtitle'),
            Text(widget.model.description ?? 'No description'),
            LinearProgressIndicator(value: _calculateFraction(widget.model)),
            Text(
                '${widget.model.numParticipants} / ${widget.model.participantsGoal}'),
            Container(
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: _buildTags(widget.model)),
              height: 30,
            ),
            ElevatedButton(onPressed: () {}, child: Text('Subscribe'))
          ],
        ),
      ),
    );
  }

  double _calculateFraction(CrowdActionModel model) {
    int participants = model.numParticipants ?? 0;
    int goal = model.participantsGoal ?? 1;
    if (goal <= 0) {
      return 0.0;
    }
    if (participants >= goal) {
      return 1.0;
    } else {
      return participants / goal;
    }
  }

  List<Chip> _buildTags(CrowdActionModel model) {
    List<String> tags = model.tags ?? [];
    return tags.map((e) => Chip(label: Text(e))).toList();
  }
}
