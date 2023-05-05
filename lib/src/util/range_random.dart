import 'dart:math' as math;

/// Returns a random integer between [lower] (inclusive) and [higher]
/// (exclusive) bounds.
int randomInRange(int lower, int higher, {math.Random? random}) {
  final rand = random ?? math.Random();
  final min = math.min(lower, higher);
  final max = math.max(lower, higher);

  return rand.nextInt(max - min) + min;
}
