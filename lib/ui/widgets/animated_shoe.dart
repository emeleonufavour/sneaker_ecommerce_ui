import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AnimatedShoe extends StatefulWidget {
  final String imageUrl;
  final Offset startPosition;
  final Offset endPosition;
  final VoidCallback onComplete;

  const AnimatedShoe({
    Key? key,
    required this.imageUrl,
    required this.startPosition,
    required this.endPosition,
    required this.onComplete,
  }) : super(key: key);

  @override
  _AnimatedShoeState createState() => _AnimatedShoeState();
}

class _AnimatedShoeState extends State<AnimatedShoe>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          left: widget.startPosition.dx +
              (widget.endPosition.dx - widget.startPosition.dx) *
                  _animation.value,
          top: widget.startPosition.dy +
              (widget.endPosition.dy - widget.startPosition.dy) *
                  _animation.value,
          child: Opacity(
            opacity: 1 - _animation.value,
            child: SizedBox(
              width: 300 * (1 - _animation.value),
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        );
      },
    );
  }
}
