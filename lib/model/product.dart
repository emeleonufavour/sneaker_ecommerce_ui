// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  int id;
  String image;
  String name;
  String description;
  double price;
  String color;

  Product(
      {required this.id,
      required this.image,
      required this.name,
      required this.description,
      required this.price,
      required this.color});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'name': name,
      'description': description,
      'price': price,
      'color': color,
    };
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      image: map['image'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      color: map['color'] as String,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, image: $image, name: $name, description: $description, price: $price, color: $color)';
  }
}
