part of '../core.dart';

extension TextStyleX on TextStyle {
  /// Returns [TextStyle] with a line height of [lineHeight] px or
  /// [this] if [fontSize] is null.
  ///
  /// [TextStyle] provides [height] property which is a scale factor
  /// rather than a static value, thus requiring us to calculate
  /// the scale factor with the formula of:
  ///
  /// scale factor = line height (in px) / font size (in px).
  ///
  /// This method provides a convenient way to describe intended
  /// line height rather than having the calculation in our UI code.
  TextStyle withLineHeight(double lineHeight) {
    if (fontSize == null) return this;

    return copyWith(height: lineHeight / fontSize!);
  }
}
