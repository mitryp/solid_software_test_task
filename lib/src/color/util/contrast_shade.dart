import 'package:flutter/material.dart';

/// The quantity of color aspects in a color not including transparency aspect.
const colorAspectsQuantity = 3;

/// The quantity of bits in each color aspect.
const bitsInColorAspect = 8;

/// Returns a [Color] which is a shade of gray contrast to the given color.
/// Computing this value is computationally expensive.
Color computeContrastShade(Color color) =>
    _makeContrastColor(color.computeLuminance());

Color _makeContrastColor(double luminance) {
  const contrastLuminanceThreshold = 0.4;

  return luminance >= contrastLuminanceThreshold ? Colors.black : Colors.white;
}
