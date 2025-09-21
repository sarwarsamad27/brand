import 'dart:io';

import 'package:brand/generate/companySideModels/comProductEntryModel.dart';
import 'package:brand/network/base_api_services.dart';
import 'package:brand/network/network_api_services.dart';
import 'package:brand/resources/global.dart';

class ComProductEntryRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static var apiurl = Global.ComProductEntry;
  static var editProduct = Global.EditProductEntry;
  static var DeleteProduct = Global.DeleteProductEntry;

  static Future<ComProductEntryModel> addProduct({
    required String name,
    required File image,
    required String userId,
  }) async {
    try {
      // Multipart API call
      final res = await NetworkApiServices().postMultipartApi(
        apiurl,
        {
          "name": name,
          "userId": userId,
        },
        [image], // 👈 list me pass karna hai
        fileFieldName: "image", // 👈 backend field name check karo
      );

      print('📌 Product Entry Response: $res');
      return ComProductEntryModel.fromJson(res);
    } catch (e) {
      print("❌ Error in ComProductEntryRepository: $e");
      return ComProductEntryModel(message: "Error occurred: $e");
    }
  }
}
