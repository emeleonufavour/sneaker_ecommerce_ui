import 'package:shoe_ecommerce_mobile/repository/product_repo.dart';
import 'package:shoe_ecommerce_mobile/service/product_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app_setup.locator.dart';
import '../../../model/product.dart';

List<Product> products = [
  Product(
      id: 1,
      image:
          "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/air-zoom-pegasus-36-mens-running-shoe-wide-D24Mcz-removebg-preview.png",
      name: "Nike Air Zoom Pegasus 36",
      description:
          "The iconic Nike Air Zoom Pegasus 36 offers more cooling and mesh that targets breathability across high-heat areas. A slimmer heel collar and tongue reduce bulk, while exposed cables give you a snug fit at higher speeds.",
      price: 108.97,
      color: "#e1e7ed"),
  Product(
      id: 2,
      image:
          "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/air-zoom-pegasus-36-shield-mens-running-shoe-24FBGb__1_-removebg-preview.png",
      name: "Nike Air Zoom Pegasus 36 Shield",
      description:
          "The Nike Air Zoom Pegasus 36 Shield gets updated to conquer wet routes. A water-repellent upper combines with an outsole that helps create grip on wet surfaces, letting you run in confidence despite the weather.",
      price: 89.87,
      color: "#4D317F"),
  Product(
      id: 3,
      image:
          "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/cruzrone-unisex-shoe-T2rRwS-removebg-preview.png",
      name: "Nike CruzrOne",
      description:
          "Designed for steady, easy-paced movement, the Nike CruzrOne keeps you going. Its rocker-shaped sole and plush, lightweight cushioning let you move naturally and comfortably. The padded collar is lined with soft wool, adding luxury to every step, while mesh details let your foot breathe. There’s no finish line—there’s only you, one step after the next.",
      price: 100.97,
      color: "#E8D026"),
  Product(
      id: 4,
      image:
          "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/epic-react-flyknit-2-mens-running-shoe-2S0Cn1-removebg-preview.png",
      name: "Nike Epic React Flyknit 2",
      description:
          "The Nike Epic React Flyknit 2 takes a step up from its predecessor with smooth, lightweight performance and a bold look. An updated Flyknit upper conforms to your foot with a minimal, supportive design. Underfoot, durable Nike React technology defies the odds by being both soft and responsive, for comfort that lasts as long as you can run.",
      price: 89.97,
      color: "#FD584A"),
  Product(
      id: 5,
      image:
          "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/odyssey-react-flyknit-2-mens-running-shoe-T3VG7N-removebg-preview.png",
      name: "Nike Odyssey React Flyknit 2",
      description:
          "The Nike Odyssey React Flyknit 2 provides a strategic combination of lightweight Flyknit construction and synthetic material for support. Underfoot, Nike React cushioning delivers a soft, springy ride for a route that begs to be crushed.",
      price: 71.97,
      color: "#D4D7D6")
];

class HomeViewModel extends BaseViewModel {
  final _productRepository = ProductRepository();
  final _productService = locator<ProductService>();

  // Product getFirstShoe() => _productService.getProducts[0];
  List<Product> get getShoes => products;
}
