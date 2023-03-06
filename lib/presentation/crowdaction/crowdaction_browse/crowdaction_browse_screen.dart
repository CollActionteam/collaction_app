import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../application/crowdaction/crowdaction_getter/crowdaction_getter_bloc.dart';
import '../../../domain/crowdaction/crowdaction.dart';
import '../../../infrastructure/core/injection.dart';
import '../../shared_widgets/custom_app_bars/custom_appbar.dart';
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
          if (state is Initial) {
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
          } else if (state is Success) {
            pagingController.appendPage(
              state.crowdActions,
              state.pageInfo.page + 1,
            );
          } else if (state is Finished) {
            pagingController.appendLastPage(state.crowdActions);
          }
        },
        child: Scaffold(
          appBar: const CustomAppBar(
            title: "Browse CrowdActions",
          ),
          body: RefreshIndicator(
            color: kAccentColor,
            onRefresh: () async {
              pagingController.refresh();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: PagedListView.separated(
                pagingController: pagingController,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
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
      ),
    );
  }
}
