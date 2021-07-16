import 'package:collaction_app/api/api.dart';
import 'package:collaction_app/models/crowd_action_model.dart';
import 'package:collaction_app/crowd_actions_details_route.dart';
import 'utilities.dart';
import 'package:flutter/material.dart';
import 'dart:math';

/// Route for the user to browse available Collactions.
class CrowdActionBrowseRoute extends StatefulWidget {
  const CrowdActionBrowseRoute({Key? key}) : super(key: key);

  @override
  _CrowdActionBrowseRouteState createState() => _CrowdActionBrowseRouteState();
}

class _CrowdActionBrowseRouteState extends State<CrowdActionBrowseRoute> {


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
          
          List<CrowdActionModel> models = snapshot.data as List<CrowdActionModel>;
          return ListView.builder(
            itemCount: models.length,
            itemBuilder: (BuildContext context, int index) {
              CrowdActionModel model = models[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Utilities.launchRoute(
                      context,
                      CrowdActionDetailsRoute(model: model),
                    );
                  },
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
        }
      ),
    );
  }
}
