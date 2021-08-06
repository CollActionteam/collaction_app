// import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
// import 'package:flutter/material.dart';

// /// Route displaying more information of a specific selected Collaction
// class CrowdActionDetailsPage extends StatefulWidget {
//   final CrowdAction model;

//   const CrowdActionDetailsPage({Key? key, required this.model})
//       : super(key: key);

//   @override
//   _ActionDetailScreenState createState() => _ActionDetailScreenState();
// }

// class _ActionDetailScreenState extends State<CrowdActionDetailsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           children: [
//             Text(widget.model.title),
//             Text(widget.model.subtitle),
//             Text(widget.model.description),
//             LinearProgressIndicator(value: _calculateFraction(widget.model)),
//             Text(
//                 '${widget.model.numParticipants} / ${widget.model.participantsGoal}'),
//             SizedBox(
//               height: 30,
//               child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   children: _buildTags(widget.model)),
//             ),
//             ElevatedButton(onPressed: () {}, child: const Text('Subscribe'))
//           ],
//         ),
//       ),
//     );
//   }

//   double _calculateFraction(CrowdAction model) {
//     int participants = model.numParticipants;
//     int goal = model.participantsGoal;
//     if (goal <= 0) {
//       return 0.0;
//     }
//     if (participants >= goal) {
//       return 1.0;
//     } else {
//       return participants / goal;
//     }
//   }

//   List<Chip> _buildTags(CrowdAction model) {
//     List<String> tags = model.tags ?? [];
//     return tags.map((e) => Chip(label: Text(e))).toList();
//   }
// }
