part of 'spotlight_crowdactions.dart';

class SpotlightEmptyHeader extends StatelessWidget {
  const SpotlightEmptyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black.withOpacity(0.1),
      highlightColor: Colors.white.withOpacity(0.2),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 215,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            Row(
              children: [
                const SizedBox(width: 15.0),
                SecondaryChip(text: "Sample text"),
                const SizedBox(width: 12),
                SecondaryChip(text: "Sample text"),
                const SizedBox(height: 5.0),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.black,
                    ),
                    width: 250,
                  ),
                  const SizedBox(height: 5.0),
                  Container(
                    height: 22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.black,
                    ),
                    width: 200,
                  ),
                  const SizedBox(height: 5.0),
                  Container(
                    height: 22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.black,
                    ),
                    width: 150,
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
              padding: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Colors.black,
              ),
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
