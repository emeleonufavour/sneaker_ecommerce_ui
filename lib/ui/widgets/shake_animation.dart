import 'dart:math';

import 'package:flutter/material.dart';

class ShakeAnimationWidget extends StatefulWidget {
  const ShakeAnimationWidget(
      {required this.child,
      required this.duration,
      required this.shakeCount,
      required this.shakeOffset,
      super.key});

  final Widget child;
  final double shakeOffset;
  final int shakeCount;
  final Duration duration;

  @override
  State<ShakeAnimationWidget> createState() => ShakeAnimationWidgetState();
}

class ShakeAnimationWidgetState extends State<ShakeAnimationWidget>
    with SingleTickerProviderStateMixin {
  final Duration animationDuration = const Duration(milliseconds: 500);
  late final animationController =
      AnimationController(vsync: this, duration: animationDuration);

  @override
  void initState() {
    animationController.addStatusListener(_updateStatus);
    super.initState();
  }

  @override
  void dispose() {
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reset();
    }
  }

  void shake() {
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: widget.child,
      builder: (context, child) {
        final sineValue =
            sin(widget.shakeCount * 2 * pi * animationController.value);
        return Transform.rotate(
          angle: sineValue / 2,
          // offset: Offset(sineValue * widget.shakeOffset, 0),
          child: child,
        );
      },
    );
  }
}
