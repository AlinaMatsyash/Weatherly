import 'package:flutter/material.dart';

abstract final class AppRadius {
  static const double small = 8;
  static const double medium = 16;
  static const double large = 24;
  static const double hero = 32;

  static const smallBorder = BorderRadius.all(Radius.circular(small));
  static const mediumBorder = BorderRadius.all(Radius.circular(medium));
  static const largeBorder = BorderRadius.all(Radius.circular(large));
  static const heroBorder = BorderRadius.all(Radius.circular(hero));
}
