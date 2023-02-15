import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';

/// Dialog to search and select country for phone input
class CountrySearch extends StatefulWidget {
  final Function(CountryDetails)? onCountrySelected;

  const CountrySearch({super.key, this.onCountrySelected});

  @override
  CountrySearchState createState() => CountrySearchState();
}

class CountrySearchState extends State<CountrySearch> {
  final _countryCodes =
      CountryCodes.countryCodes().whereType<CountryDetails>().toList();
  late List<CountryDetails> _countries;

  @override
  void initState() {
    super.initState();
    _countries = List<CountryDetails>.from(
      _countryCodes
        ..sort(
          (a, b) => a.alpha2Code?.compareTo(b.alpha2Code ?? "") == 1 ? 1 : -1,
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: context.kTheme.accentColor,
                    ),
                  ),
                  onChanged: _searchCountry,
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final country = _countries[index];

                return InkWell(
                  onTap: () {
                    if (widget.onCountrySelected != null) {
                      widget.onCountrySelected!(country);
                      Navigator.of(context).pop();
                    }
                  },
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        Image.asset(
                          'icons/flags/png/${country.alpha2Code!.toLowerCase()}.png',
                          package: 'country_icons',
                          width: 28.0,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          country.dialCode!,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            country.name!,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: _countries.length,
            ),
          )
        ],
      ),
    );
  }

  /// Find country name or code matching search pattern
  void _searchCountry(String text) {
    _countries.clear();

    setState(() {
      if (text.isEmpty) {
        _countries.addAll(_countryCodes);
      } else {
        _countries.addAll(
          _countryCodes.where(
            (country) =>
                country.name?.toLowerCase().contains(text.toLowerCase()) ==
                    true ||
                country.alpha2Code?.toLowerCase().contains(text) == true ||
                country.dialCode?.contains(text) == true,
          ),
        );
      }
    });
  }
}
