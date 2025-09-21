import 'package:brand/generate/companySideModels/comLoginModel.dart';
import 'package:brand/network/base_api_services.dart';
import 'package:brand/network/network_api_services.dart';
import 'package:brand/resources/global.dart';

class ComLoginRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static var apiurl = Global.CompLogin;

  static Future<ComLoginModel> comLogin(
      String name, String email, String password) async {
    try {
      final res = await apiService.postApi(apiurl, {
        "name": name,
        "email": email,
        "password": password,
      });

      print('📌 Final Response Map: $res');
      return ComLoginModel.fromJson(res);
    } catch (e) {
      print("❌ Error in LoginRepository: $e");
      return ComLoginModel(message: "Error occurred: $e");
    }
  }
}
