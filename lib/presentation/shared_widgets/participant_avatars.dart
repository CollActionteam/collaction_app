import 'package:cached_network_image/cached_network_image.dart';
// ignore: depend_on_referenced_packages
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shimmer/shimmer.dart';

import '../../application/participation/top_participants/top_participants_bloc.dart';
import '../../core/core.dart';
import '../../domain/participation/participation.dart';
import '../../infrastructure/core/injection.dart';
import 'shimmers/top_participants_shimmer.dart';

class TopParticipantAvatars extends StatelessWidget {
  final String crowdActionId;

  const TopParticipantAvatars({
    super.key,
    required this.crowdActionId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TopParticipantsBloc>(
      create: (context) => getIt<TopParticipantsBloc>()
        ..add(
          TopParticipantsEvent.fetchParticipants(
            crowdActionId: crowdActionId,
          ),
        ),
      child: BlocBuilder<TopParticipantsBloc, TopParticipantsState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => const SizedBox.shrink(),
            fetching: (_) => Shimmer.fromColors(
              baseColor: context.colors.primaryColor100!,
              highlightColor: context.colors.primaryColor200!,
              child: const TopParticipantsShimmer(),
            ),
            fetched: (state) => SizedBox(
              width: state.topParticipants.length == 1
                  ? 40.0
                  : state.topParticipants.length == 3
                      ? 90.0
                      : 65.0,
              child: Stack(
                children: state.topParticipants
                    .asMap()
                    .entries
                    .map(
                      (participant) => _createAvatar(
                        participant.value,
                        participant.key,
                        state.topParticipants.length,
                      ),
                    )
                    .toList(),
              ),
            ),
            failure: (_) => const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  Align _createAvatar(Participation participant, int index, int amount) {
    return Align(
      alignment: _getIndexAlignment(index, amount),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: 18,
          backgroundColor: Colors.grey[300],
          foregroundImage: CachedNetworkImageProvider(
            '${dotenv.get('BASE_STATIC_ENDPOINT_URL')}/${participant.avatar}',
            imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet,
            errorListener: () {},
          ),
          backgroundImage: const AssetImage('assets/images/default_avatar.png'),
          onForegroundImageError: (_, __) {},
        ),
      ),
    );
  }

  Alignment _getIndexAlignment(int index, int amount) {
    if (amount == 3) {
      switch (index) {
        case 0:
          return Alignment.centerRight;
        case 1:
          return Alignment.center;
        default:
          return Alignment.centerLeft;
      }
    }

    if (amount == 2) {
      return index == 1 ? Alignment.centerLeft : Alignment.centerRight;
    }

    return Alignment.centerLeft;
  }
}
