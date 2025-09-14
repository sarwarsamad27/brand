import 'package:brand/network/base_api_services.dart';
import 'package:brand/network/network_api_services.dart';
import 'package:brand/resources/global.dart';

class LoginRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static var apiurl = Global.Login;

  static Future<Map<String, dynamic>> userLogin(
      String email, String password) async {
    try {
      final res = await apiService.postApi(apiurl, {
        "email": email,
        "password": password,
      });

      print('Final Response Map: $res');
      return res;
    } catch (e) {
      return {
        'code_status': false,
        'message': 'Error occurred: $e',
      };
    }
  }
}
