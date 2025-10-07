import 'package:brand/generate/userSideModel/orderCreateModel.dart';
import 'package:brand/network/base_api_services.dart';
import 'package:brand/network/network_api_services.dart';
import 'package:brand/resources/global.dart';

class OrderCreateRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static var apiurl = Global.CreateOrder;

  static Future<OrderCreateModel> createOrder({
    required String userId,
    required String name,
    required String email,
    required String phone,
    required String city,
    required String postalCode,
    required String address,
    required List<Map<String, dynamic>> products,
  }) async {
    try {
      final body = {
        "userId": userId,
        "name": name,
        "email": email,
        "phone": phone,
        "city": city,
        "postalCode": postalCode,
        "address": address,
        "products": products,
      };

      final res = await apiService.postApi(apiurl, body);

      print('📌 Order Create Response: $res');
      return OrderCreateModel.fromJson(res);
    } catch (e) {
      print("❌ Error in OrderCreateRepository: $e");
      return OrderCreateModel(message: "Error occurred: $e");
    }
  }
}
