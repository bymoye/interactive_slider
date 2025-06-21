import 'package:flutter/material.dart';
import 'package:interactive_slider/interactive_slider.dart';

class InteractiveSliderPainter extends CustomPainter {
  InteractiveSliderPainter({
    required this.progress,
    required Color color,
    this.gradient,
    required this.gradientSize,
    this.numberOfSegments,
    required this.segmentDividerColor,
    required this.segmentDividerWidth,
    this.direction = Axis.horizontal,
  })  : _rectPaint = Paint()..color = color,
        super(repaint: progress);

  final ValueNotifier<double> progress;
  final Gradient? gradient;
  final GradientSize gradientSize;
  final int? numberOfSegments;
  final Color segmentDividerColor;
  final double segmentDividerWidth;
  final Axis direction;
  final Paint _rectPaint;
  @override
  void paint(Canvas canvas, Size size) {
    final progressRect = switch (direction) {
      Axis.horizontal =>
        Rect.fromLTWH(0, 0, progress.value * size.width, size.height),
      Axis.vertical => Rect.fromLTWH(
          0,
          size.height - (progress.value * size.height),
          size.width,
          progress.value * size.height,
        ),
    };

    if (gradient case var gradient?) {
      final sizeRect = switch (gradientSize) {
        GradientSize.totalWidth => Rect.fromLTWH(0, 0, size.width, size.height),
        GradientSize.progressWidth => progressRect,
      };
      _rectPaint.shader = gradient.createShader(sizeRect);
    }

    if (numberOfSegments case int numberOfSegments) {
      final dividerPaint = Paint()
        ..color = segmentDividerColor
        ..strokeWidth = segmentDividerWidth
        ..style = PaintingStyle.stroke;

      if (direction == Axis.horizontal) {
        final segmentWidth = size.width / numberOfSegments;
        final progressRect = Rect.fromLTWH(
          0,
          0,
          (progress.value * numberOfSegments).round() * segmentWidth,
          size.height,
        );
        canvas.drawRect(progressRect, _rectPaint);
        for (var segment = 1; segment < numberOfSegments; segment++) {
          final position = segmentWidth * segment;
          canvas.drawLine(
            Offset(position, 0),
            Offset(position, size.height),
            dividerPaint,
          );
        }
      } else {
        final segmentHeight = size.height / numberOfSegments;
        final progressSegments = (progress.value * numberOfSegments).round();
        final progressRect = Rect.fromLTWH(
          0,
          size.height - (progressSegments * segmentHeight),
          size.width,
          progressSegments * segmentHeight,
        );
        canvas.drawRect(progressRect, _rectPaint);
        for (var segment = 1; segment < numberOfSegments; segment++) {
          final position = segmentHeight * segment;
          canvas.drawLine(
            Offset(0, position),
            Offset(size.width, position),
            dividerPaint,
          );
        }
      }
    } else {
      canvas.drawRect(progressRect, _rectPaint);
    }
  }

  @override
  bool shouldRepaint(InteractiveSliderPainter oldDelegate) =>
      progress.value != oldDelegate.progress.value ||
      _rectPaint.color != oldDelegate._rectPaint.color;
}
