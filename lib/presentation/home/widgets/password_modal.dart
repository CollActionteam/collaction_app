import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../domain/core/i_settings_repository.dart';
import '../../../domain/crowdaction/crowdaction.dart';
import '../../../infrastructure/core/injection.dart';
import '../../../presentation/core/collaction_icons.dart';
import '../../../presentation/routes/app_routes.gr.dart';
import '../../../presentation/themes/constants.dart';

class PasswordModal extends StatefulWidget {
  final CrowdAction crowdAction;
  const PasswordModal({Key? key, required this.crowdAction}) : super(key: key);

  @override
  State<PasswordModal> createState() => _PasswordModalState();
}

class _PasswordModalState extends State<PasswordModal> {
  late bool _showInput;
  late bool _disableButton;
  bool? _validated;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _showInput = true;
    _disableButton = true;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 380),
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(CollactionIcons.lock, size: 20),
          Column(
            children: [
              Text(
                'Enter password',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: kPrimaryColor400,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                'This crowdaction is private. Please enter the password to see it.',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: kPrimaryColor300,
                      fontSize: 12,
                    ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _controller,
              onChanged: (value) => _validateInput(value),
              onSubmitted: (value) => _validatePassword(),
              style: const TextStyle(fontSize: 17, letterSpacing: 2.0),
              obscureText: _showInput,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide:
                      const BorderSide(width: 0, color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide:
                      const BorderSide(width: 0, color: Colors.transparent),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(width: 2, color: Colors.red),
                ),
                errorText: _validated != null && _validated == false
                    ? "Invalid password"
                    : null,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(width: 2, color: Colors.red),
                ),
                suffixIcon: IconButton(
                  icon: _showInput
                      ? const Icon(CollactionIcons.eye)
                      : const Icon(CollactionIcons.eyeOff),
                  onPressed: () {
                    setState(() {
                      _showInput = !_showInput;
                    });
                  },
                  splashRadius: 2,
                ),
              ),
              obscuringCharacter: '*',
              cursorColor: kAccentColor,
            ),
          ),
          CircleAvatar(
            backgroundColor: _disableButton ? kPrimaryColor200 : kAccentColor,
            minRadius: 30,
            child: IconButton(
              onPressed: () {
                if (_disableButton == true) {
                  return;
                } else {
                  _validatePassword();
                }
              },
              icon: const Icon(CollactionIcons.arrowRight),
              color: kSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _validateInput(String value) {
    setState(() {
      value == "" ? _disableButton = true : _disableButton = false;
    });
  }

  void _validatePassword() {
    if (_controller.text == widget.crowdAction.passwordJoin) {
      setState(() {
        _validated = true;
      });
      addCrowdActionAccess();
      context.router.pop();
      context.router.push(
        CrowdActionDetailsRoute(
          crowdAction: widget.crowdAction,
        ),
      );
    } else {
      setState(() {
        _validated = false;
      });
    }
  }

  Future<void> addCrowdActionAccess() async {
    final _settingsRepository = getIt<ISettingsRepository>();
    await _settingsRepository.addCrowdActionAccess(
        crowdActionId: widget.crowdAction.crowdactionID);
  }
}
