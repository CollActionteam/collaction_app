part of '../crowdaction_comments_page.dart';

class CommentAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Color color;

  CommentAppBarDelegate({required this.expandedHeight, required this.color});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        ColoredBox(color: color),
        if (shrinkOffset < 100) ...[
          _buildHeaderContent(),
          Positioned(
            top: kToolbarHeight,
            child: IconButton(
              icon: const Icon(CollactionIcons.left),
              iconSize: 24,
              onPressed: () => context.router.pop(),
              color: Colors.white,
            ),
          )
        ] else
          _buildAppBar(),
      ],
    );
  }

  Widget _buildHeaderContent() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Comments',
              style: kTitle1.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'See what others are saying about this crowdaction and join in on the conversation',
              style: kCaption1.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 2,
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: color,
    );
  }

  @override
  double get maxExtent => expandedHeight + kToolbarHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
