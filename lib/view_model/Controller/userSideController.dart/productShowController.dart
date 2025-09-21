import 'package:brand/generate/userSideModel/productShowModel.dart';
import 'package:brand/view_model/Repository/UserRepository/ProductShowRepository.dart';
import 'package:flutter/material.dart';

class ProductShowController with ChangeNotifier {
  bool isLoading = false;
  ProductShowModel? productModel;
  String? currentBrandId; // 👈 add this

  Future<void> loadProducts(String userId, String brandId) async {
    isLoading = true;
    currentBrandId = brandId; // 👈 update here
    notifyListeners();

    productModel =
        await ProductShowRepository.productShowFetch(brandId, userId);

    isLoading = false;
    notifyListeners();
  }
}
