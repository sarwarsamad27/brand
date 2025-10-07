import 'dart:io';
import 'package:brand/generate/companySideModels/comFormModel.dart';
import 'package:brand/network/base_api_services.dart';
import 'package:brand/network/network_api_services.dart';
import 'package:brand/resources/global.dart';

class ComFormRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static var apiurl = Global.CompForm;

  static Future<CompFormModel> comForm({
    required String name,
    required File image,
    required String email,
    required String mobile,
    required String address,
    required String description,
  }) async {
    try {
      final res = await NetworkApiServices().postMultipartApi(
        apiurl,
        {
          "name": name,
          "email": email,
          "mobile": mobile,
          "address": address,
          "description": description,
        },
        [image], // 👈 list me file
        fileFieldName: "image", // 👈 backend field ka naam check karna
      );

      print('📌 Company Form Response: $res');
      return CompFormModel.fromJson(res);
    } catch (e) {
      print("❌ Error in ComFormRepository: $e");
      return CompFormModel(message: "Error occurred: $e");
    }
  }
}
