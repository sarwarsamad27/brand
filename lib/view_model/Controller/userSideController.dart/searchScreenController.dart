import 'dart:math';
import 'package:flutter/material.dart';
import 'package:brand/generate/userSideModel/searchProductModel.dart';
import 'package:brand/view_model/Repository/UserRepository/searchProductRepository.dart';

class SearchProductController with ChangeNotifier {
  bool isLoading = false;
  List<Products> allProducts = [];
  List<Products> filteredProducts = [];

  /// Fetch all products (call only once or on refresh)
  Future<void> fetchProducts() async {
    try {
      isLoading = true;
      notifyListeners();

      final res = await SearchProductRepository.searchProductFetch();
      allProducts = res.products ?? [];
      filteredProducts = [...allProducts];
    } catch (e) {
      print("❌ Error in fetchProducts: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Filter by name
  void searchProduct(String query) {
    if (query.isEmpty) {
      filteredProducts = [...allProducts];
    } else {
      filteredProducts = allProducts
          .where((p) =>
              (p.productName ?? "")
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              (p.productDescription ?? "")
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  /// Shuffle products
  void shuffleProducts() {
    filteredProducts.shuffle(Random());
    notifyListeners();
  }
}
