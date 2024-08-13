import 'package:stacked/stacked.dart';

import '../model/product.dart';

class ProductService with ListenableServiceMixin {
  final ReactiveValue<List<Product>> _products =
      ReactiveValue<List<Product>>([]);

  ProductService() {
    listenToReactiveValues([_products]);
  }

  List<Product> get getProducts => _products.value;

  set setProducts(List<Product> products) {
    _products.value = products;
    notifyListeners();
  }
}
