import 'package:brand/generate/userSideModel/productShowModel.dart';
import 'package:brand/network/base_api_services.dart';
import 'package:brand/network/network_api_services.dart';
import 'package:brand/resources/global.dart';

class ProductShowRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static var apiurl = Global.ProductDetailShow;

  static Future<ProductShowModel> productShowFetch(
      String brandId, String userId) async {
    try {
      // ✅ Query Params manually URL me add karo
      final fullUrl = "$apiurl?brandId=$brandId&userId=$userId";

      print("🌍 Final API URL: $fullUrl");

      final res = await apiService.getApi(fullUrl);

      print('📌 Final Response Map: $res');
      return ProductShowModel.fromJson(res);
    } catch (e) {
      print("❌ Error in ProductShowRepository: $e");
      return ProductShowModel(message: "Error occurred: $e");
    }
  }
}
