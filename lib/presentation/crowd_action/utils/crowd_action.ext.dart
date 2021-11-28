import 'package:flutter/cupertino.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../shared_widgets/secondary_chip.dart';

extension CrowdActionX on CrowdAction {
  List<Widget> toChips() {
    return [
      if (category != null) ...[SecondaryChip(text: category ?? "")],
      if (subCategory != null) ...[SecondaryChip(text: subCategory ?? "")],
    ];
  }
}
