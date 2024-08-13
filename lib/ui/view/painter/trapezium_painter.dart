import 'package:flutter/material.dart';
import 'dart:math';

class QuadrilateralPainter extends CustomPainter {
  final double borderRadius;
  final Color color;

  QuadrilateralPainter({this.borderRadius = 20.0, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    // Define points
    final bottomLeft = Offset(0, size.height);
    final bottomRight = Offset(size.width, size.height);

    // Top right: 130 degrees facing up (50 degrees from horizontal)
    final topRightX = size.width;
    final topRightY =
        size.height * 0.4; // Adjust this factor to control right side height
    final topRight = Offset(topRightX, topRightY);

    // Top left: 45 degrees facing down
    final double topLeftX = 0;
    final double topLeftY = 0;
    final topLeft = Offset(topLeftX, topLeftY);

    // Draw the quadrilateral
    path.moveTo(bottomLeft.dx, bottomLeft.dy);
    path.lineTo(bottomRight.dx, bottomRight.dy);
    path.lineTo(topRight.dx, topRight.dy);
    path.lineTo(topLeft.dx, topLeft.dy);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
