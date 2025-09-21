import 'package:brand/generate/userSideModel/productShowModel.dart';
import 'package:flutter/material.dart';

class ProductDetailController with ChangeNotifier {
  bool isLoading = false;
  Products? product;
  List<Products> relatedProducts = [];

  Future<void> loadProductDetail(
      Products productData, List<Products> folderProducts) async {
    isLoading = true;
    notifyListeners();

    product = productData;

    // ✅ Same product ko related list se hatao
    relatedProducts = folderProducts
        .where((p) => p.sId != productData.sId) // compare product id
        .toList();

    isLoading = false;
    notifyListeners();
  }
}
