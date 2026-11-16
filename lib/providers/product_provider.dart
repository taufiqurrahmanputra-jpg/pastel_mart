
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service_products.dart';

class ProductProvider extends ChangeNotifier {
  final ApiServiceProducts _apiService = ApiServiceProducts();

  List<Product> _products = [];
  List<Product> _filteredProducts = [];

  bool _isLoading = false;
  String? _errorMessage;
  String _searchQuery = '';

  List<Product> get products => _filteredProducts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;

  // Mengambil seluruh produk dari API
  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await _apiService.getAllProducts();
      _filteredProducts = _products;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Melakukan pencarian produk
  Future<void> searchProducts(String query) async {
    _searchQuery = query;

    if (query.trim().isEmpty) {
      _filteredProducts = _products;
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _filteredProducts =
          await _apiService.searchProducts(query.trim());
    } catch (e) {
      _errorMessage = e.toString();
      _filteredProducts = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
