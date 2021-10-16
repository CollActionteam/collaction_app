import 'package:collaction_app/presentation/auth/utils/countries.dart';
import 'package:flutter/material.dart';

class CountrySearch extends StatefulWidget {
  final Function(Country)? onCountrySelected;

  const CountrySearch({Key? key, this.onCountrySelected}) : super(key: key);

  @override
  _CountrySearchState createState() => _CountrySearchState();
}

class _CountrySearchState extends State<CountrySearch> {
  final _countries = List<Country>.from(countries);

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
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: _searchCountry,
                ),
              ) /*,
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Icon(Icons.close),
              )*/
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
                          'icons/flags/png/${country.code.toLowerCase()}.png',
                          package: 'country_icons',
                          width: 28.0,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          country.dial_code,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Text(
                          country.name,
                          overflow: TextOverflow.ellipsis,
                        ))
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
        _countries.addAll(countries);
      } else {
        _countries.addAll(countries.where((country) =>
            country.name.toLowerCase().contains(text.toLowerCase()) ||
            country.code.toLowerCase().contains(text) ||
            country.dial_code.contains(text)));
      }
    });
  }
}
