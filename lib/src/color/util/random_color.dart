import 'dart:math';
import 'dart:ui';

import 'package:solid_software_test_task/src/util/range_random.dart';

/// Returns a random opaque [Color] between [min] and [max] bounds inclusive.
/// The transparency of the given color bounds is ignored.
Color randomOpaqueColor(Color min, Color max, [Random? random]) {
  final colorValue = randomInRange(min.value, max.value + 1, random);

  return Color(_setFullOpacity(colorValue));
}

/// This mask can be applied using bitwise OR to set the color to be fully
/// opaque.
const _opaqueColorMask = 0xff000000;

// or this can be done using [Color.withOpacity] or [Color.withAlpha] method.
int _setFullOpacity(int colorValue) => colorValue | _opaqueColorMask;
