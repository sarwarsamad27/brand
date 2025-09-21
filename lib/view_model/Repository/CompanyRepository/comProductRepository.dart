import 'package:brand/generate/companySideModels/comProductModel.dart';
import 'package:brand/network/base_api_services.dart';
import 'package:brand/network/network_api_services.dart';
import 'package:brand/resources/global.dart';

class ComProductRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static var apiurl = Global.ComProduct;

  static Future<ComProductModel> productFetch(
      String userId, String brandId) async {
    try {
      final fullUrl = "$apiurl?userId=$userId&brandId=$brandId";
      print("🌍 Final API URL: $fullUrl");

      final res = await apiService.getApi(fullUrl);
      print('📌 Final Response Map: $res');

      return ComProductModel.fromJson(res);
    } catch (e) {
      print("❌ Error in ProductShowRepository: $e");
      return ComProductModel(message: "Error occurred: $e");
    }
  }
}
