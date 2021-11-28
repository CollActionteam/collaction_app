import 'package:flutter/cupertino.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../shared_widgets/secondary_chip.dart';
import '../../shared_widgets/sign_up_chip.dart';

extension CrowdActionX on CrowdAction {
  List<Widget> toChips() {
    return [
      SignUpChip(),
      if (category != null) ...[SecondaryChip(text: category ?? "")],
      if (subCategory != null) ...[SecondaryChip(text: subCategory ?? "")],
    ];
  }
}