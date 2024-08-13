import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoe_ecommerce_mobile/repository/product_repo.dart';
import 'package:shoe_ecommerce_mobile/ui/view/home/home_vm.dart';
import 'package:shoe_ecommerce_mobile/ui/widgets/text_widget.dart';
import 'package:stacked/stacked.dart';
import '../../../helpers/degree_helper.dart';
import '../../widgets/trapezium.dart';

class HomePage extends StatelessWidget {
  ProductRepository product = ProductRepository();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, _) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Column(children: [
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  SizedBox(
                      height: size.height * 0.05,
                      width: size.width * 0.2,
                      child: SvgPicture.asset("assets/svg/nike.svg")),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextWidget(
                            title: "Men's Running           Shoe",
                            fontWeight: FontWeight.w700,
                            textColor: Colors.black,
                            textAlign: TextAlign.left,
                            fontSize: 35,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10.0, bottom: (size.height * 0.12)),
                            child: Container(
                              height: size.height * 0.009,
                              width: size.width * 0.2,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    height: size.height * 0.5,
                    child: ShoeListView(size: size, model: model),
                  ),
                ]),
              ),
            ),
          );
        });
  }
}

class ShoeListView extends StatefulWidget {
  final Size size;
  final HomeViewModel model;

  const ShoeListView({Key? key, required this.size, required this.model})
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
              final slideY = -50.0 * (1 - progress);

              return SizedBox(
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
                  // Shoe Name
                  Positioned(
                    bottom: widget.size.height * 0.09,
                    left: widget.size.width * 0.12 + slideX,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          title: (widget.model.getShoes[index]).name,
                          textColor: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                        TextWidget(
                          title: "\$${(widget.model.getShoes[index]).price}",
                          textColor: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ),
                  // Shoe Image
                  Positioned(
                    top: widget.size.height * 0.001 + slideY,
                    right: widget.size.width * 0.1 + slideX,
                    child: SizedBox(
                      width: widget.size.width * 0.7,
                      child: Transform.scale(
                        scale: scale,
                        child: Transform.rotate(
                            angle: angle,
                            child: Image.network(
                                (widget.model.getShoes[index]).image)),
                      ),
                    ),
                  ),
                ]),
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
