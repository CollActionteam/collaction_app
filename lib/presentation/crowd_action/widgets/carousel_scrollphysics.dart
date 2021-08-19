import 'package:flutter/material.dart';

class CarouselScrollPhysics extends ScrollPhysics {
  final double itemDimension;

  const CarouselScrollPhysics(
      {required this.itemDimension, ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CarouselScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CarouselScrollPhysics(
        itemDimension: itemDimension, parent: buildParent(ancestor));
  }

  double _getPage(ScrollPosition position, double portion) {
    return (position.pixels + portion) / itemDimension;
  }

  double _getPixels(double page, double portion) {
    return (page * itemDimension) - portion;
  }

  double _getTargetPixels(
    ScrollPosition position,
    Tolerance tolerance,
    double velocity,
    double portion,
  ) {
    double page = _getPage(position, portion);
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    return _getPixels(page.roundToDouble(), portion);
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }

    final Tolerance tolerance = this.tolerance;
    final portion = (position.extentInside - itemDimension) / 2;
    final double target = _getTargetPixels(
        position as ScrollPosition, tolerance, velocity, portion);
    if (target != position.pixels) {
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
