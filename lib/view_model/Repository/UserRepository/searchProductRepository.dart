import 'package:brand/generate/userSideModel/searchProductModel.dart';
import 'package:brand/network/base_api_services.dart';
import 'package:brand/network/network_api_services.dart';
import 'package:brand/resources/global.dart';

class SearchProductRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static var apiurl = Global.SearchProduct;

  static Future<AllProductModel> searchProductFetch() async {
    try {
      // ✅ Query Params manually URL me add karo

      print("🌍 Final API URL: $apiurl");

      final res = await apiService.getApi(apiurl);

      print('📌 Final Response Map: $res');
      return AllProductModel.fromJson(res);
    } catch (e) {
      print("❌ Error in ProductShowRepository: $e");
      return AllProductModel(message: "Error occurred: $e");
    }
  }
}
