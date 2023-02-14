part of '../core.dart';

@immutable
class CollactionColors extends ThemeExtension<CollactionColors> {
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? accentColor;

  final Color? shadowColor;

  final Color? inactiveColor;
  final Color? almostTransparent;
  final Color? secondaryTransparent;

  final Color? enabledButtonColor;
  final Color? disabledButtonColor;

  final Color? errorColor;
  final Color? successColor;

  final Color? irisColor;

  final Color? primaryColor0;
  final Color? primaryColor100;
  final Color? primaryColor200;
  final Color? primaryColor300;
  final Color? primaryColor400;
  final Color? primaryColor500;

  const CollactionColors({
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    required this.shadowColor,
    required this.inactiveColor,
    required this.almostTransparent,
    required this.secondaryTransparent,
    required this.enabledButtonColor,
    required this.disabledButtonColor,
    required this.errorColor,
    required this.successColor,
    required this.irisColor,
    required this.primaryColor0,
    required this.primaryColor100,
    required this.primaryColor200,
    required this.primaryColor300,
    required this.primaryColor400,
    required this.primaryColor500,
  });

  @override
  ThemeExtension<CollactionColors> copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? accentColor,
    Color? shadowColor,
    Color? inActiveColor,
    Color? almostTransparent,
    Color? secondaryTransparent,
    Color? enabledButtonColor,
    Color? disabledButtonColor,
    Color? errorColor,
    Color? successColor,
    Color? irisColor,
    Color? primaryColor0,
    Color? primaryColor100,
    Color? primaryColor200,
    Color? primaryColor300,
    Color? primaryColor400,
    Color? primaryColor500,
  }) {
    return CollactionColors(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      accentColor: accentColor ?? this.accentColor,
      shadowColor: shadowColor ?? this.shadowColor,
      inactiveColor: inActiveColor ?? this.inactiveColor,
      almostTransparent: almostTransparent ?? this.almostTransparent,
      secondaryTransparent: secondaryTransparent ?? this.secondaryTransparent,
      enabledButtonColor: enabledButtonColor ?? this.enabledButtonColor,
      disabledButtonColor: disabledButtonColor ?? this.disabledButtonColor,
      errorColor: errorColor ?? this.errorColor,
      successColor: successColor ?? this.successColor,
      irisColor: irisColor ?? this.irisColor,
      primaryColor0: primaryColor0 ?? this.primaryColor0,
      primaryColor100: primaryColor100 ?? this.primaryColor100,
      primaryColor200: primaryColor200 ?? this.primaryColor200,
      primaryColor300: primaryColor300 ?? this.primaryColor300,
      primaryColor400: primaryColor400 ?? this.primaryColor400,
      primaryColor500: primaryColor500 ?? this.primaryColor500,
    );
  }

  @override
  ThemeExtension<CollactionColors> lerp(
      covariant ThemeExtension<CollactionColors>? other, double t) {
    if (other is! CollactionColors) {
      return this;
    }

    return CollactionColors(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
      accentColor: Color.lerp(accentColor, other.accentColor, t),
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t),
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t),
      almostTransparent: Color.lerp(
        almostTransparent,
        other.almostTransparent,
        t,
      ),
      secondaryTransparent: Color.lerp(
        secondaryTransparent,
        other.secondaryTransparent,
        t,
      ),
      enabledButtonColor: Color.lerp(
        enabledButtonColor,
        other.enabledButtonColor,
        t,
      ),
      disabledButtonColor: Color.lerp(
        disabledButtonColor,
        other.disabledButtonColor,
        t,
      ),
      errorColor: Color.lerp(errorColor, other.errorColor, t),
      successColor: Color.lerp(successColor, other.successColor, t),
      irisColor: Color.lerp(irisColor, other.irisColor, t),
      primaryColor0: Color.lerp(primaryColor0, other.primaryColor0, t),
      primaryColor100: Color.lerp(primaryColor100, other.primaryColor100, t),
      primaryColor200: Color.lerp(primaryColor200, other.primaryColor200, t),
      primaryColor300: Color.lerp(primaryColor300, other.primaryColor300, t),
      primaryColor400: Color.lerp(primaryColor400, other.primaryColor400, t),
      primaryColor500: Color.lerp(primaryColor500, other.primaryColor500, t),
    );
  }

  // the light theme
  static const light = CollactionColors(
    primaryColor: Colors.black,
    secondaryColor: Color(0xFFF9F9F9),
    accentColor: Color(0xFF2EB494),
    shadowColor: Color.fromRGBO(0, 0, 0, 0.1),
    inactiveColor: Color(0xFF666666),
    almostTransparent: Color(0xFFEFEFEF),
    secondaryTransparent: Color(0xFFCCCCCC),
    enabledButtonColor: Color(0xFF2EB494),
    disabledButtonColor: Color(0xFF999999),
    errorColor: Color(0xFFE11900),
    successColor: Color(0xFF2EB494),
    irisColor: Color(0xFF5D5FEF),
    primaryColor0: Color(0xFFEFEFEF),
    primaryColor100: Color(0xFFCCCCCC),
    primaryColor200: Color(0xFF999999),
    primaryColor300: Color(0xFF666666),
    primaryColor400: Color(0xFF333333),
    primaryColor500: Color(0xFF000000),
  );

  // the dark theme
  static const dark = CollactionColors(
    primaryColor: Colors.black,
    secondaryColor: Color(0xFFF9F9F9),
    accentColor: Color(0xFF2EB494),
    shadowColor: Color.fromRGBO(0, 0, 0, 0.1),
    inactiveColor: Color(0xFF666666),
    almostTransparent: Color(0xFFEFEFEF),
    secondaryTransparent: Color(0xFFCCCCCC),
    enabledButtonColor: Color(0xFF2EB494),
    disabledButtonColor: Color(0xFF999999),
    errorColor: Color(0xFFE11900),
    successColor: Color(0xFF2EB494),
    irisColor: Color(0xFF5D5FEF),
    primaryColor0: Color(0x101010),
    primaryColor100: Color(0x333333),
    primaryColor200: Color(0x666666),
    primaryColor300: Color(0x999999),
    primaryColor400: Color(0xCCCCCC),
    primaryColor500: Colors.black,
  );
}
