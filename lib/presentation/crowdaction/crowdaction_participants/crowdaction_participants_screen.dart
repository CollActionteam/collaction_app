import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/application/fetching_participants/fetching_participants_bloc.dart';
import 'package:collaction_app/infrastructure/core/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shimmer/shimmer.dart';

import '../../themes/constants.dart';

class CrowdActionParticipantsPage extends StatelessWidget {
  final String crowdactionId;
  const CrowdActionParticipantsPage({
    Key? key,
    required this.crowdactionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: getIt<FetchingParticipantsBloc>()
          ..add(
            FetchingParticipantsEvent.fetchParticipants(
              crowdactionId,
              1,
            ),
          ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  surfaceTintColor: MaterialStateProperty.all(Colors.black),
                  elevation: MaterialStateProperty.all(2),
                  shape: MaterialStateProperty.all(
                    const CircleBorder(),
                  ),
                  minimumSize: MaterialStateProperty.all(
                    const Size(40, 40),
                  ),
                ),
                child: const Icon(
                  Icons.chevron_left,
                  size: 30,
                  color: kPrimaryColor400,
                ),
                onPressed: () {
                  context.router.pop();
                },
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 8),
                child: Text(
                  'Participants',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor400,
                        fontSize: 28,
                      ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<FetchingParticipantsBloc,
                    FetchingParticipantsState>(
                  builder: (context, state) => state.maybeMap(
                    orElse: () {
                      return Container();
                    },
                    fetchingParticipants: (_) => const Center(
                      child: CircularProgressIndicator(
                        color: kAccentColor,
                      ),
                    ),
                    fetched: (fetchedP) {
                      return ListView(
                        children: [
                          ...fetchedP.participants.map<Widget>((participant) {
                            return ListTile(
                              leading: CircleAvatar(
                                foregroundImage: NetworkImage(
                                  '${dotenv.get('BASE_STATIC_ENDPOINT_URL')}/${participant.avatar}',
                                ),
                                radius: 26,
                                child: Shimmer.fromColors(
                                  baseColor: kSecondaryTransparent,
                                  highlightColor: kAlmostTransparent,
                                  child: const CircleAvatar(radius: 50),
                                ),
                              ),
                              title: Text(
                                participant.fullName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            );
                          }).toList(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
