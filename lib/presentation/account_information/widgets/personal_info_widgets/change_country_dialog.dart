import 'package:flutter/material.dart';

import '../../../../domain/core/location.dart';
import '../../../themes/constants.dart';

class ChangeCountryDialog extends StatefulWidget {
  final Location? location;

  ChangeCountryDialog({
    super.key,
    required this.location,
  });

  @override
  State<ChangeCountryDialog> createState() => _ChangeCountryDialogState();
}

class _ChangeCountryDialogState extends State<ChangeCountryDialog> {
  late GlobalKey<FormState> _formKey;
  late GlobalKey<FormFieldState> _countryNameKey;
  late TextEditingController _countryNameController;
  late bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _countryNameKey = GlobalKey<FormFieldState>();
    _countryNameController = TextEditingController(text: widget.location?.code);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showChangeCountryDialog,
      child: Text(
        "Change",
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: kAccentColor,
              fontFamily: 'Rubik',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

// TO DO: refactor after recived a design for change country dialog
  Future<void> _showChangeCountryDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return SizedBox(
              width: 302,
              height: 200,
              child: AlertDialog(
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Change Country',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: kPrimaryColor400,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                ),
                      ),
                    ),
                  ],
                ),
                content: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: ListBody(
                      children: [
                        SizedBox(
                          height: 56,
                          child: TextFormField(
                            controller: _countryNameController,
                            key: _countryNameKey,
                            validator: (value) => _validateCountry(value),
                            onChanged: (value) => setState(() {
                              _countryNameKey.currentState!.validate()
                                  ? _isButtonEnabled = true
                                  : _isButtonEnabled = false;
                            }),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                              fillColor: kPrimaryColor0,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 6),
                          child: SizedBox(
                            height: 16,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                "Country",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(color: kPrimaryColor300),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: kEnabledButtonColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    onPressed: _isButtonEnabled
                        ? () => setState(() => Navigator.of(context).pop())
                        : null,
                    child: Text(
                      'Save',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: _isButtonEnabled
                                ? kEnabledButtonColor
                                : kDisabledButtonColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  String? _validateCountry(String? value) {
    if (value == widget.location?.code) {
      return "To save you need to make a change";
    }

    return null;
  }
}
