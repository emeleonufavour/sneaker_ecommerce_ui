import 'package:stacked/stacked.dart';

import '../model/product.dart';

class ProductService with ListenableServiceMixin {
  final ReactiveValue<List<Product>> _products =
      ReactiveValue<List<Product>>([]);
  final ReactiveValue<Map<int, Product>> _itemsInCart =
      ReactiveValue<Map<int, Product>>({});

  ProductService() {
    listenToReactiveValues([_products, _itemsInCart]);
  }

  List<Product> get getProducts => _products.value;
  List<Product> get getCartItems => _itemsInCart.value.values.toList();

  set setProducts(List<Product> products) {
    _products.value = products;
    notifyListeners();
  }

  addToCart(Product newProduct) {
    if (_itemsInCart.value.containsKey(newProduct.id)) {
      return;
    } else {
      _itemsInCart.value[newProduct.id] = newProduct;
      notifyListeners();
    }
  }

  removeItemFromCart(Product product) {
    _itemsInCart.value.remove(product.id);
    notifyListeners();
  }

  clearCart() {
    _itemsInCart.value.clear();
    notifyListeners();
  }
}
