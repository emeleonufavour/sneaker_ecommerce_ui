import 'dart:developer';

import 'package:dio/dio.dart';

import '../model/product.dart';

class ProductRepository {
  Dio dio = Dio();

  Future<bool> addProduct(Product product) async {
    try {
      Response response = await dio.post(
        'http://localhost:8080/api/products',
        data: product.toJson(),
      );
      log(response.data);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return true;
      }
    } catch (e, stackTrace) {
      log("$e || $stackTrace");
    }
    return false;
  }

  Future<List<Product>?> getAllProduct() async {
    try {
      Response response = await dio.get(
        'http://localhost:8080/api/products',
      );
      // log(response.data);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        List<Product> products =
            (response.data as List).map((e) => Product.fromJson(e)).toList();
        log("Products => ${products.toString()}");
        return products;
      }
    } catch (e, stackTrace) {
      log("$e || $stackTrace");
    }
    return null;
  }

  Future<Product?> getProductById(int id) async {
    try {
      final response = await dio.get(
        'http://localhost:8080/api/products/1',
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        Product product = Product.fromJson(response.data);
        log("Product => $product");
        return product;
      }
    } catch (e, stackTrace) {
      log("$e || $stackTrace");
    }
    return null;
  }

  Future<bool> updateProductById(int id, Product product) async {
    try {
      Response response = await dio.put(
          'http://localhost:8080/api/products/$id',
          data: product.toJson());
      log(response.data);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return true;
      }
    } catch (e, stackTrace) {
      log("$e || $stackTrace");
    }
    return false;
  }

  Future<bool> deleteProductById(int id) async {
    try {
      Response response = await dio.delete(
        'http://localhost:8080/api/products/$id',
      );
      log(response.data);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return true;
      }
    } catch (e, stackTrace) {
      log("$e || $stackTrace");
    }
    return false;
  }
}
