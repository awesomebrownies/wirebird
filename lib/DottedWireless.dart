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

    canvas.save(); // Save the canvas state

    // Rotate the canvas around its center (or any custom pivot point)
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(angle);
    canvas.translate(-size.width / 2, -size.height / 2);

    final dx = cos(0); // Default direction after rotating canvas
    final dy = sin(0);
    final totalDots = (distance / spacing).ceil();

    for (int i = -1; i < totalDots; i++) {
      final offset = (i * spacing + progress * spacing);
      if (offset > distance) continue;

      final startX = offset * dx;
      final startY = offset * dy;
      final endX = min(offset * dx + 8, distance);
      final endY = offset * dy + 2;

      canvas.drawRect(Rect.fromPoints(Offset(startX, startY), Offset(endX, endY)), paint);
    }

    canvas.restore(); // Restore the canvas to avoid affecting other drawings
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
    return RepaintBoundary(
      child: CustomPaint(
        size: const Size(0, 0),
        painter: OptimizedDottedLinePainter(
          distance: widget.distance,
          angle: widget.angle,
          spacing: widget.spacing,
          dotSize: widget.dotSize,
          color: widget.color,
          progress: _frames[_currentFrameIndex],
        ),
      ),
    );
  }
}