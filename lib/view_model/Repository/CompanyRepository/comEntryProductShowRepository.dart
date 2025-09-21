import 'package:brand/generate/companySideModels/comEntryProductShowModel.dart';
import 'package:brand/network/base_api_services.dart';
import 'package:brand/network/network_api_services.dart';
import 'package:brand/resources/global.dart';

class ProductEntryShowRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static var apiurl = Global.ComShowProductEntry;

  static Future<ComEntryProductShowModel> productShowFetch(
      String userId) async {
    try {
      final fullUrl = "$apiurl?userId=$userId";
      print("🌍 Final API URL: $fullUrl");

      final res = await apiService.getApi(fullUrl);
      print('📌 Final Response Map: $res');

      return ComEntryProductShowModel.fromJson(res);
    } catch (e) {
      print("❌ Error in ProductShowRepository: $e");
      return ComEntryProductShowModel(message: "Error occurred: $e");
    }
  }
}
