import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

class OptimizedDottedLinePainter extends CustomPainter {
  final double distance;
  final double angle;
  final double spacing;
  final double dotSize;
  final Color color;
  final double progress;

  OptimizedDottedLinePainter({
    required this.distance,
    required this.angle,
    required this.spacing,
    required this.dotSize,
    required this.color,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..isAntiAlias = false;

    final dx = cos(angle);
    final dy = sin(angle);

    final totalDots = (distance / spacing).ceil();

    for (int i = 0; i < totalDots; i++) {
      final offset = (i * spacing + progress * spacing) % distance;
      if (offset > distance) continue;

      final startX = offset * dx - 20;
      final startY = offset * dy;
      final endX = offset * dx + (8) -20;
      final endY = offset * dy + (2);

      // final rect = Rect.fromCircle(center: Offset(x, y), radius: dotSize);
      // canvas.drawOval(rect, paint);
      canvas.drawRect(Rect.fromPoints(Offset(startX, startY), Offset(endX, endY)), paint);
    }
  }

  @override
  bool shouldRepaint(OptimizedDottedLinePainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

class AnimatedLineConnector extends StatefulWidget {
  final double distance;
  final double angle;
  final double spacing;
  final double dotSize;
  final Color color;

  const AnimatedLineConnector({
    Key? key,
    required this.distance,
    required this.angle,
    this.spacing = 20.0,
    this.dotSize = 2.0,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  _AnimatedDottedLineState createState() => _AnimatedDottedLineState();
}

class _AnimatedDottedLineState extends State<AnimatedLineConnector> {
  // Cache frame values - we'll only use 3 frames
  final List<double> _frames = [0.0, 0.33, 0.66];
  int _currentFrameIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    _timer?.cancel();
    // Update every 333ms for 3 FPS
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        _currentFrameIndex = (_currentFrameIndex + 1) % _frames.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.distance-40,
      height: widget.dotSize * 2,
      child: RepaintBoundary(
        child: CustomPaint(
          size: Size(widget.distance, widget.dotSize * 2),
          painter: OptimizedDottedLinePainter(
            distance: widget.distance,
            angle: widget.angle,
            spacing: widget.spacing,
            dotSize: widget.dotSize,
            color: widget.color,
            progress: _frames[_currentFrameIndex],
          ),
        ),
      ),
    );
  }
}