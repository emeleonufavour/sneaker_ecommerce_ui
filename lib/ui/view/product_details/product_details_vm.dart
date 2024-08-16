import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoe_ecommerce_mobile/service/product_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app_setup.locator.dart';
import '../../../model/product.dart';
import '../../widgets/animated_shoe.dart';
import '../../widgets/shake_animation.dart';

class ProductDetailsViewModel extends BaseViewModel {
  final _productService = locator<ProductService>();
  Color? orignalColor;
  bool isStarAnimating = false;
  bool isStarred = false;
  final GlobalKey shoeImageKey = GlobalKey();
  final GlobalKey cartIconKey = GlobalKey();
  final GlobalKey<ShakeAnimationWidgetState> shakeStateKey =
      GlobalKey<ShakeAnimationWidgetState>();

  OverlayEntry? _overlayEntry;

  bool get isCartEmpty => _productService.getCartItems.isEmpty;

  void setIsStarAnimation(bool value) {
    isStarAnimating = value;
    notifyListeners();
  }

  void toggleIsStarred() {
    if (!isStarred) {
      isStarAnimating = !isStarAnimating;
    }
    isStarred = !isStarred;
    notifyListeners();
  }

  void showAddToCartAnimation(BuildContext context, String imageUrl) {
    final RenderBox? shoeImageRenderBox =
        shoeImageKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? cartIconRenderBox =
        cartIconKey.currentContext?.findRenderObject() as RenderBox?;

    if (shoeImageRenderBox == null || cartIconRenderBox == null) {
      log("Couldn't find the render boxes");
      return;
    }

    // final shoePosition = shoeImageRenderBox.localToGlobal(Offset.zero);
    const shoePosition = Offset(50, 100);
    final cartIconPosition = cartIconRenderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => AnimatedShoe(
        imageUrl: imageUrl,
        startPosition: shoePosition,
        endPosition: cartIconPosition,
        onComplete: () {
          _overlayEntry?.remove();
          _overlayEntry = null;
        },
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  onCartButtonPressed(BuildContext context, Product product) {
    showAddToCartAnimation(context, product.image);

    Future.delayed(const Duration(milliseconds: 700), () {
      addToCart(product);
      notifyListeners();
      shakeStateKey.currentState?.shake();
    });
  }

  // Cart functions.....
  addToCart(Product product) => _productService.addToCart(product);
}
