
import 'package:flutter_test/flutter_test.dart';
import 'package:pastel_mart/models/product.dart';

void main() {
  group('PastelMart Product Test', () {
    test('Product berhasil dibuat dari JSON', () {
      final product = Product.fromJson({
        'id': 1,
        'title': 'Essence Mascara Lash Princess',
        'description': 'Test product description',
        'category': 'beauty',
        'price': 9.99,
        'discountPercentage': 7.17,
        'rating': 4.5,
        'stock': 100,
        'thumbnail': 'https://example.com/image.png',
        'images': [
          'https://example.com/image.png',
        ],
        'brand': 'Essence',
      });

      expect(product.id, 1);
      expect(product.title, 'Essence Mascara Lash Princess');
      expect(product.category, 'beauty');
      expect(product.price, 9.99);
      expect(product.rating, 4.5);
      expect(product.stock, 100);
      expect(product.brand, 'Essence');
      expect(product.images.length, 1);
    });
  });
}
