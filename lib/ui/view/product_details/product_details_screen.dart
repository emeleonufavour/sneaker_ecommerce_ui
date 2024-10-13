import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoe_ecommerce_mobile/app/app_theme.dart';
import 'package:shoe_ecommerce_mobile/ui/view/product_details/product_details_vm.dart';
import 'package:shoe_ecommerce_mobile/ui/widgets/cart_button.dart';
import 'package:shoe_ecommerce_mobile/ui/widgets/star_widget.dart';
import 'package:shoe_ecommerce_mobile/ui/widgets/text_widget.dart';
import 'package:stacked/stacked.dart';

import '../../../model/product.dart';
import '../../widgets/animated_shoe.dart';
import '../../widgets/shake_animation.dart';
import '../../widgets/star_animation.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  Color color;

  ProductDetailsScreen({required this.product, required this.color, super.key});

  // Animation handling the shoe animation to the cart icon in the app bar

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ProductDetailsViewModel(),
        onViewModelReady: (model) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            // model.orignalColor = color;
            // Future.delayed(const Duration(milliseconds: 400), () {
            //   setState(() {
            //     model.orignalColor = widget.color;
            //     // widget.color = Colors.grey; // New color to change to
            //   });
            // });
          });
        },
        builder: (context, model, _) {
          return Scaffold(
            backgroundColor: AppTheme.backgroundColor,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(CupertinoIcons.back),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ShakeAnimationWidget(
                    key: model.shakeStateKey,
                    duration: const Duration(milliseconds: 500),
                    shakeCount: 1,
                    shakeOffset: 1,
                    child: Stack(children: [
                      // show if cart is not empty
                      if (!model.isCartEmpty)
                        const Positioned(
                            top: 2,
                            right: 7,
                            child: CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.red,
                            )),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Icon(
                          key: model.cartIconKey,
                          CupertinoIcons.cart,
                          color: Colors.black,
                        ),
                      ),
                    ]),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                Stack(
                  children: [
                    Hero(
                      tag: color,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        width: size.width,
                        height: size.height * 0.5,
                        decoration: BoxDecoration(
                          color: color,
                        ),
                      ),
                    ),
                    // Shoe Image
                    Positioned(
                      right: 50,
                      child: Hero(
                        tag: product.id,
                        key: ValueKey(product.id),
                        child: SizedBox(
                          key: model.shoeImageKey,
                          width: size.width * 0.7,
                          child: CachedNetworkImage(
                            imageUrl: product.image,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    //Like effect when shoe is favourited
                    Positioned(
                      right: 120,
                      top: 120,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: model.isStarAnimating ? 1 : 0,
                        child: StarAnimation(
                          isAnimate: model.isStarAnimating,
                          onEnd: () => model.setIsStarAnimation(false),
                          duration: const Duration(milliseconds: 400),
                          smallLike: false,
                          child: const Icon(
                            CupertinoIcons.heart_fill,
                            color: Colors.white,
                            size: 150,
                          ),
                        ),
                      ),
                    ),
                    // Shoe name
                    Positioned(
                      bottom: 70,
                      left: 30,
                      child: Hero(
                        tag: product.name,
                        child: TextWidget(
                          title: product.name,
                          textColor: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    // Shoe price
                    Positioned(
                      bottom: 30,
                      right: 30,
                      child: Hero(
                        tag: product.price,
                        child: TextWidget(
                          title: "\$${product.price}",
                          textColor: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                // Sizes of shoe and amount to buy
                Padding(
                  padding: EdgeInsets.all(15).copyWith(top: 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Sizes of shoes
                        const Row(
                          children: [
                            SizeContainer(size: 10),
                            SizeContainer(size: 10.5),
                            SizeContainer(size: 11.5),
                          ],
                        ),
                        // Amount to buy
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Icon(
                                Icons.minimize,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: TextWidget(
                                title: "1",
                                fontSize: 20,
                              ),
                            ),
                            Icon(
                              Icons.add,
                              color: Colors.grey.withOpacity(0.5),
                            )
                          ],
                        )
                      ]),
                ),
                const SizedBox(
                  height: 15,
                ),
                // Product description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextWidget(
                    title: product.description,
                    textAlign: TextAlign.left,
                    fontSize: 14,
                    textColor: Colors.grey.withOpacity(1),
                  ),
                ),
                const SizedBox(
                  height: 34,
                ),
                // Star and Add to Cart
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      // Like
                      LikeWidget(
                        height: size.height * 0.08,
                        width: size.width * 0.2,
                        color: model.isStarred
                            ? Colors.red
                            : Colors.grey.withOpacity(0.5),
                        fct: () {
                          model.toggleIsStarred();
                          // setState(() {
                          //   if (!_isStarred) {
                          //     isStarAnimating = !isStarAnimating;
                          //   }

                          //   _isStarred = !_isStarred;
                          // });
                          log("tapped");
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: CartButton(
                            fct: () async =>
                                model.onCartButtonPressed(context, product),
                            label: "label",
                            buttonWidget: const Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.cart,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  TextWidget(
                                    title: "Add to cart",
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                            height: size.height * 0.08,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ]),
            ),
          );
        });
  }
}

class SizeContainer extends StatelessWidget {
  final double size;
  const SizeContainer({required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: TextWidget(title: size.toString()),
      ),
    );
  }
}

