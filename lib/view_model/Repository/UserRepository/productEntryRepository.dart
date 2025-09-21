import 'package:brand/generate/userSideModel/productEntryModel.dart';
import 'package:brand/network/base_api_services.dart';
import 'package:brand/network/network_api_services.dart';
import 'package:brand/resources/global.dart';

class ProductEntryRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static var apiurl = Global.ProductEntry; // ya apka productdetail endpoint

  static Future<ProductEntryModel?> fetchProducts(String userId) async {
    try {
      final res = await apiService.getApi("$apiurl?userId=$userId");
      print("📌 Products Response: $res");
      return ProductEntryModel.fromJson(res);
    } catch (e) {
      print("❌ Error in ProductShowRepository: $e");
      return null;
    }
  }
}
