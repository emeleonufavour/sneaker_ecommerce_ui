import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'text_widget.dart';

class StarWidget extends StatefulWidget {
  const StarWidget({
    super.key,
    required this.fct,
    required this.height,
    required this.width,
    required this.color,
  });

  final VoidCallback? fct;
  final double height;
  final double width;
  final Color color;

  @override
  State<StarWidget> createState() => _LButtonState();
}

class _LButtonState extends State<StarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward();
        HapticFeedback.lightImpact();
        Future.delayed(const Duration(milliseconds: 200), () {
          _controller.reverse();
          widget.fct!();
        });
      },
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 1.0,
          end: 0.95,
        ).animate(_controller),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          width: widget.width,
          height: widget.height,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Icon(
            CupertinoIcons.star_fill,
            size: 35,
            color: widget.color,
          ),
        ),
      ),
    );
  }
}
