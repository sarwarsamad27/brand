import 'package:brand/view_model/Repository/UserRepository/productEntryRepository.dart';
import 'package:flutter/material.dart';
import 'package:brand/generate/userSideModel/productEntryModel.dart';

class ProductEntryController with ChangeNotifier {
  bool isLoading = false;
  ProductEntryModel? productModel;
  Products? selectedProduct;

  Future<void> loadProducts(String userId) async {
    isLoading = true;
    notifyListeners();

    productModel = await ProductEntryRepository.fetchProducts(userId);

    if (productModel != null && productModel!.products!.isNotEmpty) {
      selectedProduct =
          productModel!.products!.first; // by default first select
    }

    isLoading = false;
    notifyListeners();
  }

  void selectProduct(Products product) {
    selectedProduct = product;
    notifyListeners();
  }
}
