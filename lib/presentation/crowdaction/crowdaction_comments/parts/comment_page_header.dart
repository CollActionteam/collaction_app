part of '../crowdaction_comments_page.dart';

class CommentPageHeader extends StatelessWidget {
  const CommentPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: kPrimaryColor400,
      expandedHeight: 156,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        titlePadding: const EdgeInsets.fromLTRB(10, 0, 10, 50),
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Comments',
              style: kTitle1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'See what others are saying about this crowdaction and join in on the conversation',
              style: kCaption1,
              textAlign: TextAlign.center,
              maxLines: 2,
            )
          ],
        ),
      ),
    );
  }
}
