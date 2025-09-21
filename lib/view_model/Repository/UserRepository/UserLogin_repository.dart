import 'package:brand/generate/userSideModel/loginModel.dart';
import 'package:brand/network/base_api_services.dart';
import 'package:brand/network/network_api_services.dart';
import 'package:brand/resources/global.dart';

class LoginRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static var apiurl = Global.Login;

  static Future<LoginModel> userLogin(String email, String password) async {
    try {
      final res = await apiService.postApi(apiurl, {
        "email": email,
        "password": password,
      });

      print('📌 Final Response Map: $res');
      return LoginModel.fromJson(res);
    } catch (e) {
      print("❌ Error in LoginRepository: $e");
      return LoginModel(message: "Error occurred: $e");
    }
  }
}
