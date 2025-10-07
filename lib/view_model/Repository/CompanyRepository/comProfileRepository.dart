import 'package:brand/generate/companySideModels/comFormModel.dart';
import 'package:brand/network/base_api_services.dart';
import 'package:brand/network/network_api_services.dart';
import 'package:brand/resources/global.dart';

class ComProfileRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static var apiurl = Global.CompProfile;

  static Future<CompFormModel> comProfileFetch(String email) async {
    try {
      final fullUrl = "$apiurl?email=$email";
      print("🌍 Final API URL: $fullUrl");

      final res = await apiService.getApi(fullUrl);
      print('📌 Final Response Map: $res');

      return CompFormModel.fromJson(res);
    } catch (e) {
      print("❌ Error in ProductShowRepository: $e");
      return CompFormModel(message: "Error occurred: $e");
    }
  }
}
