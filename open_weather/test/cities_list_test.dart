import 'package:flutter_test/flutter_test.dart';

void main() {}

void assertCachesEquivalent(Set<String> a, Set<String> b) {
  expect(a.length, b.length);
  assertCacheContainedIn(a, b);
}

void assertCacheContainedIn(Set<String> a, Set<String> b) {
  for (var item in a) {
    expect(b.contains(item), true);
  }
}
