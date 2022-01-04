import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:phone_number/phone_number.dart';

import '../themes/constants.dart';
import 'country_search_dialog.dart';

/// Phone input with country search and selection
class PhoneInput extends StatefulWidget {
  /// Callback for realtime input validation
  final Function(bool)? isValid;

  /// Callback with generated phone number
  final Function(PhoneResponse)? onChange;

  final bool readOnly;

  final PhoneResponse? phone;
  final TextEditingController phoneNumberController;

  const PhoneInput(
    this.phoneNumberController, {
    Key? key,
    this.isValid,
    this.onChange,
    this.phone,
    this.readOnly = false,
  }) : super(key: key);

  @override
  _PhoneInputState createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  CountryDetails? _selected;
  final _countryCodes =
      CountryCodes.countryCodes().whereType<CountryDetails>().toList();

  final plugin = PhoneNumberUtil();
  final _phoneNumberFocusNode = FocusNode();
  bool validatedNumber = false;

  @override
  void initState() {
    super.initState();

    if (widget.phone != null) {
      final country = _countryCodes
          .where((country) => country.alpha2Code == widget.phone?.country);

      /// Strip country
      _selected = country.isNotEmpty
          ? country.first
          : _countryCodes.where((country) => country.alpha2Code == "NL").first;

      /// Strip phone
      final contact = widget.phone?.contact.split(" ");

      if (contact?.isNotEmpty == true && contact?.length == 2) {
        widget.phoneNumberController.text = contact?.last ?? "";
      }
    } else {
      _selected =
          _countryCodes.where((country) => country.alpha2Code == "NL").first;
    }

    widget.phoneNumberController.addListener(() {
      if (widget.phoneNumberController.value.text.isNotEmpty) {
        _validatePhone(_selected!, widget.phoneNumberController.text);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: _showCountrySelectDialog,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).inputDecorationTheme.fillColor,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'icons/flags/png/${_selected?.alpha2Code!.toLowerCase()}.png',
                        package: 'country_icons',
                        width: 24.0,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _selected?.dialCode ?? "",
                        style: const TextStyle(fontSize: 16.0),
                        key: const Key("dialCode"),
                      ),
                      const Icon(Icons.expand_more_outlined),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  readOnly: widget.readOnly,
                  controller: widget.phoneNumberController,
                  focusNode: _phoneNumberFocusNode,
                  onEditingComplete: () async {
                    _phoneNumberFocusNode.unfocus();

                    widget.phoneNumberController.text = await plugin.format(
                      widget.phoneNumberController.text.replaceAll(' ', ''),
                      _selected!.alpha2Code!,
                    );

                    widget.phoneNumberController.selection =
                        TextSelection.fromPosition(
                      TextPosition(
                        offset: widget.phoneNumberController.text.length,
                      ),
                    );
                  },
                  style: const TextStyle(fontSize: 20.0),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Phone number',
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
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 6),
                child: Text(
                  validatedNumber
                      ? 'We will send you a code to activate your account'
                      : (widget.phoneNumberController.value.text.isEmpty
                          ? 'Enter a valid phone number'
                          : 'Your phone number is not valid'),
                  style: TextStyle(
                    color: validatedNumber
                        ? kInactiveColor
                        : widget.phoneNumberController.value.text.isEmpty
                            ? kInactiveColor
                            : kErrorColor,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  void _showCountrySelectDialog() {
    if (!widget.readOnly) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => AlertDialog(
          content: CountrySearch(
            onCountrySelected: _regionOnChange,
          ),
        ),
      );
    }
  }

  void _regionOnChange(CountryDetails? value) {
    setState(() {
      _selected = value;
      _validatePhone(value!, widget.phoneNumberController.value.text);
    });
  }

  /// Return phone input validation result [isValid]
  void _triggerValidReturn(bool isValid) {
    widget.isValid?.call(isValid);
  }

  /// Return phone number [phoneNumber]
  void _triggerPhoneReturn(PhoneResponse phoneNumber) {
    widget.onChange?.call(phoneNumber);
  }

  /// Validate the combination of the country dial code
  /// and phone body
  Future<bool> _validatePhone(CountryDetails country, String number) async {
    final dialCode = country.dialCode?.toCode();
    final phoneNumber = "$dialCode ${number.trim()}";
    validatedNumber = await plugin.validate(phoneNumber, country.alpha2Code!);

    _triggerPhoneReturn(PhoneResponse(country.alpha2Code!, phoneNumber));
    _triggerValidReturn(validatedNumber);

    return validatedNumber;
  }
}

class PhoneResponse {
  final String country;
  final String contact;

  PhoneResponse(this.country, this.contact);
}

extension DialCodeX on String {
  int toCode() => int.tryParse(replaceAll("+", "")) ?? 0;
}
