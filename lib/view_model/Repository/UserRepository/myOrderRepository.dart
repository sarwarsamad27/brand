import 'package:brand/generate/userSideModel/myOrderModel.dart';
import 'package:brand/network/base_api_services.dart';
import 'package:brand/network/network_api_services.dart';
import 'package:brand/resources/global.dart';

class MyOrdersRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static var apiurl = Global.MyOrders;

  static Future<MyOrdersModel> myOrderFetch(String userId) async {
    try {
      // ✅ Query Params manually URL me add karo
      final fullUrl = "$apiurl?userId=$userId";

      print("🌍 Final API URL: $fullUrl");

      final res = await apiService.getApi(fullUrl);

      print('📌 Final Response Map: $res');
      return MyOrdersModel.fromJson(res);
    } catch (e) {
      print("❌ Error in ProductShowRepository: $e");
      return MyOrdersModel(message: "Error occurred: $e");
    }
  }
}
