import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_slider/interactive_slider.dart';

void main() {
  group('InteractiveSlider Direction Tests', () {
    testWidgets('creates horizontal slider by default',
        (WidgetTester tester) async {
      const slider = InteractiveSlider();
      expect(slider.direction, Axis.horizontal);
    });

    testWidgets('creates vertical slider when specified',
        (WidgetTester tester) async {
      const slider = InteractiveSlider(direction: Axis.vertical);
      expect(slider.direction, Axis.vertical);
    });

    testWidgets('has proper default margins for horizontal slider',
        (WidgetTester tester) async {
      const slider = InteractiveSlider();
      expect(
          slider.unfocusedMargin, const EdgeInsets.symmetric(horizontal: 16));
    });

    testWidgets('has proper default margins for vertical slider',
        (WidgetTester tester) async {
      const slider = InteractiveSlider(direction: Axis.vertical);
      expect(slider.unfocusedMargin, const EdgeInsets.symmetric(vertical: 16));
    });
  });
}
