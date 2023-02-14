import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../shared_widgets/pill_button.dart';
import '../../../shared_widgets/selectable_chip.dart';

class FlagComment extends StatelessWidget {
  final bool flagged;

  const FlagComment({
    super.key,
    this.flagged = false,
  });

  @override
  Widget build(BuildContext context) {
    /// to be replaced with a BlocBuilder to swap between dialog and success
    if (!flagged) {
      return FlagDialog(
        /// need clarification - will these be defined/accessible in the API? do we need a flag obj?
        flags: ["Spam", "Illegal", "Hateful", "Sexual", "Other"],
      );
    }
    return FlagSuccess();
  }
}

class FlagDialog extends StatefulWidget {
  final bool isLoading;
  final List<String> flags;

  const FlagDialog({
    super.key,
    this.isLoading = false,
    this.flags = const [],
  });

  @override
  State<FlagDialog> createState() => FlagDialogState();
}

class FlagDialogState extends State<FlagDialog> {
  late List<String> _flags;
  late List<bool> _selectedFlags;
  late bool _isLoading;

  void updateFlag(int index) {
    setState(() {
      _selectedFlags[index] = !_selectedFlags[index];
    });
  }

  @override
  void initState() {
    super.initState();
    _isLoading = widget.isLoading;
    _flags = widget.flags;
    _selectedFlags = List.filled(_flags.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(
          height: 15,
        ),
        Container(
          width: 60.0,
          height: 5.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: context.colors.secondaryTransparent,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Report comment",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          constraints: const BoxConstraints(maxHeight: 300),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 80),
                child: Text(
                  "Modal description. Nam quis nulla. Integer malesuada. In in enim a arcu imperdiet malesuada. Sed vel lectus. Donec odio uma, tempus molestie, porttitor ut, iaculis quis.",
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: context.colors.primaryColor400,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  direction: Axis.horizontal,
                  children: List.generate(_flags.length, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: SelectableChip(
                        onTap: () => setState(() {
                          _selectedFlags[index] = !_selectedFlags[index];
                        }),
                        selected: _selectedFlags[index],
                        text: _flags[index],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        PillButton(
          text: "Report Comment",
          isLoading: _isLoading,
          isEnabled: _selectedFlags.contains(true),
          margin: EdgeInsets.zero,
          onTap: () {
            /// do something with _selectedFlags - CommentEvent.flagComment?
          },
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: TextButton(
            onPressed: () => context.router.pop(),
            child: const Text("Cancel"),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ]),
    );
  }
}

class FlagSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            width: 60.0,
            height: 5.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: context.colors.secondaryTransparent,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Report comment",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 28,
          ),
          Text(
            "Successfully reported",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: Text(
              "Thank you for letting us know. We will look into it and dlete the comment if necessary.",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.colors.primaryColor400,
                  ),
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.symmetric(horizontal: 50),
            alignment: Alignment.center,
          ),
          const SizedBox(
            height: 20,
          ),
          PillButton(
            text: "Got it",
            onTap: () {
              context.router.pop();
            },
            margin: EdgeInsets.zero,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: TextButton(
              onPressed: () {
                /// undo flagging
              },
              child: const Text("Undo"),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
