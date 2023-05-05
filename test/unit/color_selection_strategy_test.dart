import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solid_software_test_task/src/color/next_color_selection_strategy.dart';
import 'package:solid_software_test_task/src/color/util/random_color.dart';

import '../test_util.dart';

void main() {
  group('NextColorSelectionStrategy tests', () {
    test('RandomNextColorStrategy works as expected', () {
      repeat((_) {
        final initialColor = randomOpaqueColor(Colors.black, Colors.white);
        final strategy = RandomNextColorStrategy(initialColor: initialColor);

        expect(
          strategy.nextColor(),
          initialColor,
          reason: 'RandomNextColorStrategy.nextColor calls without arguments '
              'should return the initial color',
        );

        expect(
          () =>
              strategy.nextColor(randomOpaqueColor(Colors.black, Colors.white)),
          returnsNormally,
          reason: 'RandomNextColorStrategy.nextColor calls with arguments'
              'should return value',
        );
      });
    });
  });
}
