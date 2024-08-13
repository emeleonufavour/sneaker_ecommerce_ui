import 'package:shoe_ecommerce_mobile/app/app_setup.locator.dart';
import 'package:shoe_ecommerce_mobile/model/product.dart';
import 'package:shoe_ecommerce_mobile/service/product_service.dart';
import 'package:stacked/stacked.dart';

import '../../../repository/product_repo.dart';

class OnboardingViewModel extends BaseViewModel {
  final _productService = locator<ProductService>();
  final _productRepo = ProductRepository();

  getAllShoes() async {
    List<Product>? products = await _productRepo.getAllProduct();
    if (products != null) {
      _productService.setProducts = products;
      notifyListeners();
    }
  }
}
