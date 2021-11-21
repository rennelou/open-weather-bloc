import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather/main.dart';

void main() {
  testWidgets('Add new city', (WidgetTester tester) async {
    var initialState = {
      'Curitiba, BR',
      'Sydney, AU',
      'London, GB',
      'London, CA'
    };

    await tester.pumpWidget(const MyApp());

    for (var item in initialState) {
      expect(find.text(item), findsOneWidget);
    }

    expect(find.text('sao paulo, br'), findsNothing);

    // Add new city
    await tester.enterText(find.byType(TextField), 'sao paulo, br');
    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();

    /*
    expect(find.text('sao paulo, br'), findsOneWidget);
    for (var item in initialState) {
      expect(find.text(item), findsNothing);
    }

    // Show all list
    await tester.enterText(find.byType(TextField), '');
    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();

    expect(find.text('sao paulo, br'), findsOneWidget);
    for (var item in initialState) {
      expect(find.text(item), findsOneWidget);
    }
    */
  });
}

void assertCachesEquivalent(Set<String> a, Set<String> b) {
  expect(a.length, b.length);
  assertCacheContainedIn(a, b);
}

void assertCacheContainedIn(Set<String> a, Set<String> b) {
  for (var item in a) {
    expect(b.contains(item), true);
  }
}
