// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('Interactive Slider app loads correctly',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app title is shown.
    expect(find.text('Interactive Slider'), findsOneWidget);

    // Verify that we have horizontal and vertical slider sections.
    expect(find.text('Horizontal Sliders'), findsOneWidget);
    expect(find.text('Vertical Sliders'), findsOneWidget);

    // Verify that Min/Max buttons exist.
    expect(find.text('Min'), findsOneWidget);
    expect(find.text('Max'), findsOneWidget);
  });
}
