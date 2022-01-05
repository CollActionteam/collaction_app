import 'package:flutter/widgets.dart';

import '../../presentation/core/collaction_icons.dart';

const crowdActionCommitmentIcons = {
  'no-beef': CollactionIcons.no_beef,
  'working-days-only': CollactionIcons.five_out_of_seven,
  'vegan': CollactionIcons.vegan,
  'vegetarian': CollactionIcons.vegetarian,
  'pescatarian': CollactionIcons.pescatarian,
  'no-dairy': CollactionIcons.no_dairy,
  'no-cheese': CollactionIcons.no_cheese,
};

IconData idToIcon(String id) => crowdActionCommitmentIcons[id]!;
