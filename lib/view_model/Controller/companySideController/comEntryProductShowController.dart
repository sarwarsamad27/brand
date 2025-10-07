import 'package:brand/view_model/Repository/CompanyRepository/comEntryProductShowRepository.dart';
import 'package:flutter/material.dart';
import 'package:brand/generate/companySideModels/comEntryProductShowModel.dart';

class ComEntryProductShowController with ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  List<Product> _products = [];
  List<Product> _filteredProducts = [];

  List<Product> get products => _products;
  List<Product> get filteredProducts =>
      _filteredProducts.isEmpty ? _products : _filteredProducts;
  bool _hasFetched = false;

  /// ✅ API call to fetch products
  Future<void> fetchProducts(String userId) async {
    if (_hasFetched) return; // skip if already fetched
    _hasFetched = true;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response =
          await ProductEntryShowRepository.productShowFetch(userId);

      if (response.products != null && response.products!.isNotEmpty) {
        _products = response.products!;
      } else {
        _products = [];
        errorMessage = response.message ?? "No products found";
      }
    } catch (e) {
      errorMessage = "Error: $e";
    }

    isLoading = false;
    notifyListeners();
  }

  /// ✅ Search filter
  void filterProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = [];
    } else {
      _filteredProducts = _products
          .where((p) => p.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  /// ✅ Local delete
  void deleteProduct(String id) {
    _products.removeWhere((p) => p.sId == id);
    _filteredProducts.removeWhere((p) => p.sId == id);
    notifyListeners();
  }
}
