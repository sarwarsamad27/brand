import 'package:brand/generate/companySideModels/comRegisterModel.dart';
import 'package:brand/network/base_api_services.dart';
import 'package:brand/network/network_api_services.dart';
import 'package:brand/resources/global.dart';

class ComSignUpRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static var apiurl = Global.CompRegister;

  static Future<ComRegisterModel> comRegister(
      String name, String email, String password) async {
    try {
      final res = await apiService.postApi(apiurl, {
        "name": name,
        "email": email,
        "password": password,
      });

      print('📌 Final Response Map: $res');
      return ComRegisterModel.fromJson(res);
    } catch (e) {
      print("❌ Error in ComSignUpRepository: $e");
      return ComRegisterModel(message: "Error occurred: $e");
    }
  }
}
