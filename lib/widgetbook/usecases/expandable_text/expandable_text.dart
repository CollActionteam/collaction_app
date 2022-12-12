import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../../presentation/shared_widgets/expandable_text.dart';

@WidgetbookUseCase(name: 'ExpandableText', type: ExpandableText)
Widget expandableText(BuildContext context) {
  return Center(
    child: ExpandableText(
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi blandit a mi non hendrerit. Aliquam posuere pellentesque sodales. Integer mattis enim id dictum lacinia. Nam consectetur ornare vulputate. Nam euismod pulvinar auctor. Etiam eleifend imperdiet ligula a commodo. Donec sed lacinia ipsum. \n\nUt ut metus at leo aliquam mattis ullamcorper vel metus. Nunc neque ipsum, interdum non lectus in, pharetra viverra sapien. Proin urna felis, vestibulum eu ligula vitae, sodales finibus massa. Integer laoreet nunc ac volutpat faucibus. Cras blandit id elit quis mollis. Aliquam semper elementum ultrices. Suspendisse fermentum luctus nulla, ac ullamcorper est. Praesent enim arcu, sodales nec semper et, ultricies at urna. Nunc in rutrum nibh, sed luctus quam.",
    ),
  );
}
