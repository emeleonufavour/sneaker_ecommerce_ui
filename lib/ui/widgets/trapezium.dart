import 'package:flutter/material.dart';

import '../view/painter/trapezium_painter.dart';

class TrapeziumContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final Decoration? decoration;
  final EdgeInsetsGeometry? margin;

  TrapeziumContainer(
      {required this.height,
      required this.width,
      required this.margin,
      required this.color,
      required this.decoration});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: QuadrilateralPainter(color: color),
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: decoration,
      ),
    );
  }
}
