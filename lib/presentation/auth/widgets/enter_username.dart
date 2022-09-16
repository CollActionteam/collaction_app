import 'package:collaction_app/application/username/username_bloc.dart';
import 'package:collaction_app/infrastructure/core/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared_widgets/pill_button.dart';
import '../../themes/constants.dart';

class EnterUserName extends StatefulWidget {
  final void Function(String fullname) onDone;
  const EnterUserName({
    Key? key,
    required this.onDone,
  }) : super(key: key);

  @override
  _EnterUserNameState createState() => _EnterUserNameState();
}

class _EnterUserNameState extends State<EnterUserName> {
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isNameValid = false;
  String? _firstname;
  String? _lastname;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsernameBloc>(
      create: (context) => getIt<UsernameBloc>(),
      child: BlocListener<UsernameBloc, UsernameState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            updateInProgress: () {
              /// TODO: Loading indication
            },
            updateSuccess: (fullname) {
              widget.onDone(fullname);
            },
            updateFailure: () {
              /// TODO: Show error snackbar | Implement failures
            },
          );
        },
        child: BlocBuilder<UsernameBloc, UsernameState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'How should we call\r\n you?',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 32.0,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'Enter your first name or use a recognizable name that others can identify you by',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: kInactiveColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 45.0),
                Form(
                  key: _formKey,
                  onChanged: () => setState(
                    () => _isNameValid =
                        _formKey.currentState?.validate() == true,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _firstnameController,
                        onChanged: (firstname) => _firstname = firstname,
                        style: const TextStyle(fontSize: 20.0),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Your First Name',
                          focusColor: kAccentColor,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                              width: 0,
                              color: Colors.transparent,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                              width: 0,
                              color: Colors.transparent,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                              width: 0,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        validator: (value) => _validateName(value),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                        ],
                      ),
                      const SizedBox(height: 25.0),
                      TextFormField(
                        controller: _lastnameController,
                        onChanged: (lastname) => _lastname = lastname,
                        style: const TextStyle(fontSize: 20.0),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Your Last Name',
                          focusColor: kAccentColor,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                              width: 0,
                              color: Colors.transparent,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                              width: 0,
                              color: Colors.transparent,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                              width: 0,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        validator: (value) => _validateName(
                          value,
                          firstName: false,
                          minLength: 4,
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: PillButton(
                        text: 'Next',
                        isLoading: state.maybeWhen(
                          orElse: () => false,
                          updateInProgress: () => true,
                        ),
                        isEnabled: state.maybeWhen(
                              orElse: () => true,
                              updateInProgress: () => false,
                            ) &&
                            _isNameValid,
                        onTap: () {
                          if (_isNameValid &&
                              state.maybeWhen(
                                orElse: () => true,
                                updateInProgress: () => false,
                              )) {
                            FocusScope.of(context).unfocus();
                            context.read<UsernameBloc>().add(
                                  UsernameEvent.updateUsername(
                                    firstName: _firstname!,
                                    lastName: _lastname!,
                                  ),
                                );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String? _validateName(
    String? value, {
    bool firstName = true,
    int minLength = 2,
  }) {
    if (value == null || value.trim().isEmpty) {
      return "${firstName ? 'First' : 'Last'} name is required";
    }

    if (value.length < minLength || value.length > 20) {
      return "${firstName ? 'First' : 'Last'} name should be between 4 and 60 characters long";
    }

    if (!value.startsWith(RegExp("[a-zA-Z]"))) {
      return "${firstName ? 'First' : 'Last'} name should start with a letter or number";
    }

    return null;
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    super.dispose();
  }
}
