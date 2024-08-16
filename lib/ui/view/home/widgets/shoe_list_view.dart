import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../helpers/degree_helper.dart';
import '../../../widgets/text_widget.dart';
import '../../../widgets/trapezium.dart';
import '../../product_details/product_details_screen.dart';
import '../home_vm.dart';

class ShoeListView extends StatefulWidget {
  final Size size;
  final HomeViewModel model;
  GlobalKey heroKey = GlobalKey();

  ShoeListView({Key? key, required this.size, required this.model})
      : super(key: key);

  @override
  _ShoeListViewState createState() => _ShoeListViewState();
}

class _ShoeListViewState extends State<ShoeListView>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  double _scrollOffset = 0.0;
  List<Color> boxColors = [
    Colors.red,
    Colors.yellow[900]!,
    Colors.blueAccent,
    Colors.green,
    Colors.pink
  ];

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );

    _animationController.forward();
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
        itemCount: widget.model.getShoes.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final itemWidth = widget.size.width * 0.9;
          final itemScrollOffset = index * itemWidth - _scrollOffset;
          final visiblePortion =
              1 - (itemScrollOffset / itemWidth).clamp(0.0, 1.0);

          return AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final progress = _animation.value * visiblePortion;
              final scale = 0.7 + (0.5 * progress);
              final angle = Helper.degreeToRadian(24 + (-48 * visiblePortion));

              final slideX = 80.0 * (1 - progress);
              final slideY = -50.0 * (2 - progress);

              return GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ProductDetailsScreen(
                          product: widget.model.getShoes[index],
                          color: boxColors[index],
                        ),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                              position: offsetAnimation, child: child);
                        },
                        transitionDuration: const Duration(milliseconds: 400),
                        reverseTransitionDuration:
                            const Duration(milliseconds: 800),
                      ),
                      // MaterialPageRoute(

                      //   builder: (context) => ProductDetailsScreen(
                      //       product: widget.model.getShoes[index]))
                    )
                    .then(
                      (value) =>
                          Future.delayed(const Duration(milliseconds: 500), () {
                        setState(() {});
                      }),
                    ),
                child: SizedBox(
                  width: itemWidth,
                  child: Stack(children: [
                    Container(
                      width: widget.size.width * 0.85,
                      height: widget.size.height * 0.45,
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Hero(
                        tag: boxColors[index],
                        child: TrapeziumContainer(
                          width: widget.size.width * 0.80,
                          height: widget.size.height * 0.45,
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          color: boxColors[index],
                          decoration: const BoxDecoration(
                              // color: boxColors[index],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16))),
                        ),
                      ),
                    ),
                    // Shoe Name
                    Positioned(
                      bottom: widget.size.height * 0.09,
                      left: widget.size.width * 0.12 + slideX,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: (widget.model.getShoes[index]).name,
                            flightShuttleBuilder: (
                              BuildContext flightContext,
                              Animation<double> animation,
                              HeroFlightDirection flightDirection,
                              BuildContext fromHeroContext,
                              BuildContext toHeroContext,
                            ) {
                              return DefaultTextStyle(
                                style: DefaultTextStyle.of(toHeroContext).style,
                                child: toHeroContext.widget,
                              );
                            },
                            child: TextWidget(
                              title: (widget.model.getShoes[index]).name,
                              textColor: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Hero(
                            tag: (widget.model.getShoes[index]).price,
                            flightShuttleBuilder: (
                              BuildContext flightContext,
                              Animation<double> animation,
                              HeroFlightDirection flightDirection,
                              BuildContext fromHeroContext,
                              BuildContext toHeroContext,
                            ) {
                              return DefaultTextStyle(
                                style: DefaultTextStyle.of(toHeroContext).style,
                                child: toHeroContext.widget,
                              );
                            },
                            child: TextWidget(
                              title:
                                  "\$${(widget.model.getShoes[index]).price}",
                              textColor: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Shoe Image
                    Positioned(
                      top: widget.size.height * 0.001 + slideY,
                      right: widget.size.width * 0.1 + slideX,
                      child: Hero(
                        tag: (widget.model.getShoes[index]).id,
                        child: SizedBox(
                          width: widget.size.width * 0.7,
                          child: Transform.scale(
                            scale: scale,
                            child: Transform.rotate(
                              angle: angle,
                              child: CachedNetworkImage(
                                key:
                                    ValueKey((widget.model.getShoes[index]).id),
                                imageUrl: (widget.model.getShoes[index]).image,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              );
            },
          );
        });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
