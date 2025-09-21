import 'dart:io';

import 'package:brand/generate/companySideModels/createComProductModel.dart';
import 'package:brand/network/base_api_services.dart';
import 'package:brand/network/network_api_services.dart';
import 'package:brand/resources/global.dart';

class CreateProductRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static var apiurl = Global.CreateComProduct;

  static Future<CreateComProductModel> createProduct({
    required String productName,
    required List<File> images, // 👈 ab list accept karega
    required String userId,
    required String brandId,
    required String category,
    required String discount,
    required String stock,
    required String price,
    required String productDescription,
  }) async {
    try {
      final res = await NetworkApiServices().postMultipartApi(
        apiurl,
        {
          "productName": productName,
          "userId": userId,
          "brandId": brandId,
          "category": category,
          "discount": discount,
          "stock": stock,
          "price": price,
          "productDescription": productDescription,
        },
        images, // 👈 ab poori list jayegi
        fileFieldName: "images", // 👈 backend ka field confirm karna
      );

      print('📌 Product Entry Response: $res');
      return CreateComProductModel.fromJson(res);
    } catch (e) {
      print("❌ Error in CreateProductRepository: $e");
      return CreateComProductModel(message: "Error occurred: $e");
    }
  }
}
