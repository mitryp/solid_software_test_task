import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solid_software_test_task/src/util/range_random.dart';

import '../test_util.dart';

const _maxRandomValue = 9999999;

void main() {
  group('Range random tests', () {
    test(
      'Returned values are in the set limits',
      () {
        final random = Random();

        repeat((_) {
          final a = random.nextInt(_maxRandomValue);
          final b = random.nextInt(_maxRandomValue);

          final res = randomInRange(a, b);
          expect(res, inClosedOpenRange(min(a, b), max(a, b)));
        });
      },
    );

    test(
      'Returned values are the same when using the same Random seed',
      () {
        repeat((_) {
          final random = Random();
          final seed = random.nextInt(_maxRandomValue);
          final length = random.nextInt(20);

          final sequences = List.generate(
            2,
            (_) => _randomRangeSequence(
              minInt: -_maxRandomValue,
              maxInt: _maxRandomValue,
              length: length,
              random: Random(seed),
            ),
          );

          expect(listEquals(sequences.first, sequences[1]), true);
        });
      },
    );
  });
}

List<int> _randomRangeSequence({
  required int minInt,
  required int maxInt,
  required int length,
  Random? random,
}) {
  return List.generate(
    length,
    (index) => randomInRange(minInt, maxInt, random: random),
  );
}
