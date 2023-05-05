const _testRuns = 10000;

void repeat(void Function(int run) f, {int times = _testRuns}) {
  for (var i = 0; i < times; i++) {
    f(i);
  }
}
