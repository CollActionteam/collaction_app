import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/application/crowdaction/crowdaction_participants/crowdaction_participants_bloc.dart';
import 'package:collaction_app/core/core.dart';
import 'package:collaction_app/domain/participation/participation.dart';
import 'package:collaction_app/infrastructure/core/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../themes/constants.dart';

class CrowdActionParticipantsPage extends StatelessWidget {
  final String crowdActionId;

  CrowdActionParticipantsPage({
    super.key,
    required this.crowdActionId,
  });

  final PagingController<int, Participation> pagingController =
      PagingController(firstPageKey: 1);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CrowdActionParticipantsBloc>(
      create: (context) => getIt<CrowdActionParticipantsBloc>()
        ..add(const CrowdActionParticipantsEvent.init()),
      child: BlocListener<CrowdActionParticipantsBloc,
          CrowdActionParticipantsState>(
        listener: (context, state) {
          state.map(
            initial: (_) {
              pagingController.addPageRequestListener((pageKey) {
                BlocProvider.of<CrowdActionParticipantsBloc>(context).add(
                  CrowdActionParticipantsEvent.getParticipants(
                    crowdActionId: crowdActionId,
                    pageNumber: pageKey,
                  ),
                );
              });

              BlocProvider.of<CrowdActionParticipantsBloc>(context).add(
                CrowdActionParticipantsEvent.getParticipants(
                  crowdActionId: crowdActionId,
                  pageNumber: 1,
                ),
              );
            },
            loading: (_) {},
            success: (state) {
              pagingController.appendPage(
                state.participants,
                state.pageInfo.page + 1,
              );
            },
            finished: (state) {
              pagingController.appendLastPage(state.participants);
            },
            failure: (_) {},
          );
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: kPrimaryColor200,
              ),
              onPressed: () => context.router.pop(),
            ),
            title: const Text(
              "Participants",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor400,
              ),
            ),
          ),
          body: RefreshIndicator(
            color: kAccentColor,
            onRefresh: () async {
              pagingController.refresh();
            },
            child: PagedListView.separated(
              pagingController: pagingController,
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              builderDelegate: PagedChildBuilderDelegate<Participation>(
                itemBuilder: (context, participation, index) => ListTile(
                  leading: CircleAvatar(
                    foregroundImage: NetworkImage(
                      NetworkConfig.participationAvatar(participation),
                    ),
                    backgroundImage: const AssetImage(
                      'assets/images/default_avatar.png',
                    ),
                    onForegroundImageError: (_, __) {},
                  ),
                  title: Text(
                    participation.fullName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontSize: 17, fontWeight: FontWeight.w300),
                  ),
                ),
                firstPageProgressIndicatorBuilder: (context) => const Center(
                  child: CircularProgressIndicator(color: kAccentColor),
                ),
                newPageProgressIndicatorBuilder: (context) => const Center(
                  child: CircularProgressIndicator(color: kAccentColor),
                ),
                firstPageErrorIndicatorBuilder: (context) => const Text(
                  'Something went wrong, try to refresh by dragging down',
                ),
                noItemsFoundIndicatorBuilder: (context) =>
                    const Text('No participants yet!'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
