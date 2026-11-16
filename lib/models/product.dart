
class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String thumbnail;
  final List<String> images;
  final String brand;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.thumbnail,
    required this.images,
    required this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discountPercentage:
          (json['discountPercentage'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      thumbnail: json['thumbnail'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      brand: json['brand'] ?? 'Unknown Brand',
    );
  }
}
