import 'package:flutter/material.dart';
import 'package:se7ety/feature/auth/data/models/specializations.dart';

/// Define a class to hold color pairs for better organization
class ColorPair {
  final Color primary;
  final Color light;

  const ColorPair(this.primary, this.light);
}

/// Predefined color pairs for specialization cards
const ColorPair skyBlue = ColorPair(Color(0xff71b4fb), Color(0xff7fbcfb));
const ColorPair orange = ColorPair(Color(0xfffa8c73), Color(0xfffa9881));
const ColorPair purple = ColorPair(Color(0xff8873f4), Color(0xff9489f4));
const ColorPair green = ColorPair(Color(0xff4cd1bc), Color(0xff5ed6c3));

/// Model for Specialization Card
class SpecializationCardModel {
  final String specialization;
  final ColorPair colorPair;

  const SpecializationCardModel({
    required this.specialization,
    required this.colorPair,
  });
}

/// Generate the list of specialization cards
final List<SpecializationCardModel> specializationsList = List.generate(
  specializations.length,
  (index) {
    final colorPair = _getColorPair(index);
    return SpecializationCardModel(
      specialization: specializations[index],
      colorPair: colorPair,
    );
  },
);

/// Helper function to assign color pairs based on index
ColorPair _getColorPair(int index) {
  switch (index % 4) {
    case 0:
      return skyBlue;
    case 1:
      return green;
    case 2:
      return orange;
    case 3:
      return purple;
    default:
      return skyBlue; // Fallback (shouldn't happen)
  }
}
