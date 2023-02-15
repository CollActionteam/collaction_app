import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/core.dart';
import '../../../shared_widgets/accent_chip.dart';
import '../../../shared_widgets/secondary_chip.dart';

class CrowdActionChips extends StatelessWidget {
  const CrowdActionChips({
    super.key,
    this.isOpen = false,
    required this.category,
    this.subCategory,
  });

  final bool isOpen;
  final String? category;
  final String? subCategory;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.0,
      children: [
        if (category != null) ...[
          ...[
            AccentChip(
              text: isOpen ? "Open" : "Closed",
              color: isOpen
                  ? context.kTheme.accentColor!
                  : context.kTheme.primaryColor200!,
            ),
            SecondaryChip(text: category!),
            if (subCategory != null) ...[SecondaryChip(text: subCategory!)],
          ]
        ] else ...[
          Shimmer.fromColors(
            baseColor: Colors.black.withOpacity(0.1),
            highlightColor: Colors.white.withOpacity(0.2),
            child: const SecondaryChip(text: "Closed"),
          ),
          Shimmer.fromColors(
            baseColor: Colors.black.withOpacity(0.1),
            highlightColor: Colors.white.withOpacity(0.2),
            child: const SecondaryChip(text: "ShimmerPlaceholder"),
          )
        ]
      ],
    );
  }
}
