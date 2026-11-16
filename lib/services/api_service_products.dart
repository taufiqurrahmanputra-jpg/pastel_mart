
import 'package:dio/dio.dart';
import '../models/product.dart';

class ApiServiceProducts {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  // Mengambil seluruh produk dengan pagination
  Future<List<Product>> getAllProducts() async {
    try {
      List<Product> allProducts = [];
      int skip = 0;
      const int limit = 100;
      int total = 0;

      do {
        final response = await _dio.get(
          '/products',
          queryParameters: {
            'limit': limit,
            'skip': skip,
          },
        );

        final data = response.data;
        final List productsJson = data['products'];

        allProducts.addAll(
          productsJson.map(
            (json) => Product.fromJson(json),
          ),
        );

        total = data['total'];
        skip += limit;
      } while (skip < total);

      return allProducts;
    } on DioException catch (e) {
      throw Exception(
        'Gagal mengambil produk: ${e.message}',
      );
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  // Mencari produk berdasarkan kata kunci
  Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await _dio.get(
        '/products/search',
        queryParameters: {
          'q': query,
          'limit': 0,
        },
      );

      final List productsJson = response.data['products'];

      return productsJson
          .map((json) => Product.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        'Gagal mencari produk: ${e.message}',
      );
    }
  }

  // Mengambil detail produk berdasarkan ID
  Future<Product> getProductById(int id) async {
    try {
      final response = await _dio.get('/products/$id');

      return Product.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        'Gagal mengambil detail produk: ${e.message}',
      );
    }
  }
}
