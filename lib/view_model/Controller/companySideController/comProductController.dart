import 'package:brand/generate/companySideModels/comProductModel.dart';
import 'package:brand/view_model/Repository/CompanyRepository/comProductRepository.dart';
import 'package:flutter/material.dart';

class ComProductController with ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  List<Product> productList = [];

  /// 🔹 Fetch Products from API
  Future<void> fetchProducts(String userId, String brandId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await ComProductRepository.productFetch(userId, brandId);

      if (response.products != null && response.products!.isNotEmpty) {
        productList = response.products!;
      } else {
        errorMessage = response.message ?? "No products found";
      }
    } catch (e) {
      errorMessage = "❌ Error: $e";
    }

    isLoading = false;
    notifyListeners();
  }

  /// 🔹 Add New Product Locally (sabse upar add hoga)
  void addProduct(Product product) {
    productList.insert(0, product); // naya product list ke top pe
    notifyListeners();
  }
}
