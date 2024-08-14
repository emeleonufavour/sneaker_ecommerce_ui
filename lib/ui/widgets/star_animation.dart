import 'package:flutter/widgets.dart';

class StarAnimation extends StatefulWidget {
  final Widget child;
  final bool isAnimate;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smallLike;
  const StarAnimation(
      {required this.child,
      required this.isAnimate,
      required this.onEnd,
      required this.duration,
      required this.smallLike,
      super.key});

  @override
  State<StarAnimation> createState() => _StarAnimationState();
}

class _StarAnimationState extends State<StarAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2));
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

//called when current widget is replaced by another widget
  @override
  void didUpdateWidget(covariant StarAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isAnimate != oldWidget.isAnimate) {
      startAnimation();
    }
  }

  startAnimation() async {
    if (widget.isAnimate || widget.smallLike) {
      await controller.forward();
      await controller.reverse();
      await Future.delayed(const Duration(milliseconds: 200));

      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
