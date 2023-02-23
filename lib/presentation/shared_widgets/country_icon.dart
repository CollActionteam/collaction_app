import 'package:flutter/material.dart';

class CountryIcon extends StatelessWidget {
  final String countryCode;
  final double? radius;

  const CountryIcon({super.key, required this.countryCode, this.radius});

  @override
  Widget build(BuildContext context) {
    Image countryImg = Image.asset(
        'icons/flags/png/${countryCode.toLowerCase()}.png',
        package: 'country_icons');

    return CircleAvatar(
        radius: radius ?? 20, backgroundImage: countryImg.image);
  }
}
