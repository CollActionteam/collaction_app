import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../application/crowdaction/crowdaction_getter/crowdaction_getter_bloc.dart';
import '../../../domain/crowdaction/crowdaction.dart';
import '../../../infrastructure/core/injection.dart';
import '../../shared_widgets/micro_crowdaction_card.dart';
import '../../themes/constants.dart';

class CrowdActionBrowsePage extends StatelessWidget {
  CrowdActionBrowsePage({super.key});

  final PagingController<int, CrowdAction> pagingController =
      PagingController(firstPageKey: 1);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CrowdActionGetterBloc>(
      create: (context) => getIt<CrowdActionGetterBloc>()
        ..add(const CrowdActionGetterEvent.init()),
      child: BlocListener<CrowdActionGetterBloc, CrowdActionGetterState>(
        listener: (context, state) {
          state.map(
            initial: (_) {
              pagingController.addPageRequestListener((pageKey) {
                BlocProvider.of<CrowdActionGetterBloc>(context).add(
                  CrowdActionGetterEvent.getCrowdActions(
                    pageNumber: pageKey,
                  ),
                );
              });

              BlocProvider.of<CrowdActionGetterBloc>(context).add(
                const CrowdActionGetterEvent.getCrowdActions(
                  pageNumber: 1,
                ),
              );
            },
            loading: (_) {},
            success: (state) {
              pagingController.appendPage(
                state.crowdActions,
                state.pageInfo.page + 1,
              );
            },
            finished: (state) {
              pagingController.appendLastPage(state.crowdActions);
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
              "Browse CrowdActions",
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
              builderDelegate: PagedChildBuilderDelegate<CrowdAction>(
                itemBuilder: (context, crowdAction, index) =>
                    MicroCrowdActionCard(
                  crowdAction,
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
                    const Text('No crowdactions yet!'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
