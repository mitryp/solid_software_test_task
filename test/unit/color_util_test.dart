import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solid_software_test_task/src/color/util/contrast_shade.dart';
import 'package:solid_software_test_task/src/color/util/random_color.dart';

import '../test_util.dart';

void main() {
  group('Random color tests', () {
    test('Output colors are in the range specified', () {
      final random = Random();

      repeat((_) {
        final minColorValue = random.nextInt(0xffffff) + 0xff000000;
        final maxColorValue = random.nextInt(0xffffff) + 0xff000000;

        final color = randomOpaqueColor(
          Color(minColorValue),
          Color(maxColorValue),
        );

        expect(color.opacity, 1, reason: 'The color should be opaque');
        expect(
          color.value,
          inInclusiveRange(
            min(minColorValue, maxColorValue),
            max(minColorValue, maxColorValue),
          ),
          reason: 'The color value should be in the specified range',
        );
      });
    });
  });

  group('Contrast shades calculation tests', () {
    test(
      'The computed colors are contrast enough to the initial color',
      () {
        repeat((_) {
          final initialColor = randomOpaqueColor(Colors.black, Colors.white);
          final computed = computeContrastShade(initialColor);

          final contrastRatio =
              _computeContrastRatio(initialColor, computed).ceilToDouble();

          const minAcceptableContrast = 3;
          expect(
            contrastRatio,
            greaterThanOrEqualTo(minAcceptableContrast),
            reason: 'Color $computed should by contrast to $initialColor '
                '(luminance ${initialColor.computeLuminance()})',
          );
        });
      },
    );
  });
}

double _computeContrastRatio(Color c1, Color c2) {
  final l1 = c1.computeLuminance();
  final l2 = c2.computeLuminance();

  final lighter = max(l1, l2);
  final darker = min(l1, l2);

  const addition = 0.05;

  return (lighter + addition) / (darker + addition);
}
