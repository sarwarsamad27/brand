import 'package:brand/generate/userSideModel/exploreModel.dart';
import 'package:brand/network/base_api_services.dart';
import 'package:brand/network/network_api_services.dart';
import 'package:brand/resources/global.dart';

class ExploreRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static var apiurl = Global.Explore;

  static Future<ExploreModel> fetchUserExplore(
      String name, String image) async {
    try {
      final res = await apiService.getApi(apiurl);

      print('Final Response Map: $res');
      return ExploreModel.fromJson(res);
    } catch (e) {
      print('Error occurred: $e');
      return ExploreModel.fromJson({
        'code_status': false,
        'message': 'Error occurred: $e',
      });
    }
  }
}
