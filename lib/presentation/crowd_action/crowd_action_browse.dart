import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../api/api.dart';
import '../../models/crowd_action_model.dart';
import '../routes/app_routes.gr.dart';

/// Route for the user to browse available Collactions.
class CrowdActionBrowsePage extends StatefulWidget {
  const CrowdActionBrowsePage({Key? key}) : super(key: key);

  @override
  _CrowdActionBrowsePageState createState() => _CrowdActionBrowsePageState();
}

class _CrowdActionBrowsePageState extends State<CrowdActionBrowsePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<Object>(
          future: API.fetchCrowdActions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }

            List<CrowdActionModel> models =
                snapshot.data as List<CrowdActionModel>;
            return ListView.builder(
              itemCount: models.length,
              itemBuilder: (BuildContext context, int index) {
                CrowdActionModel model = models[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => context.router
                        .push(CrowdActionDetailsRoute(model: model)),
                    child: Container(
                      color: Colors.grey,
                      width: double.infinity,
                      height: 50,
                      child: Text(model.title ?? 'No title'),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
