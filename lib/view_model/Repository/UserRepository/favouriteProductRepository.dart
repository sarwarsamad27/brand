import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/generate/userSideModel/AddFavouriteModel.dart';
import 'package:brand/generate/userSideModel/favouriteProductModel.dart';
import 'package:brand/network/base_api_services.dart';
import 'package:brand/network/network_api_services.dart';
import 'package:brand/resources/global.dart';

class FavouriteProductRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static var fetchFavourite = Global.FavouriteProduct;
  static var AddFavourite = Global.AddtoCart;
  static var deleteFavourite = Global.DeleteFavouriteProduct;

  static Future<FavouriteProductModel> fetchFavourites(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      userId = prefs.getString("id") ?? "";
      final fullUrl = "$fetchFavourite/$userId";
      final res = await apiService.getApi(fullUrl);
      return FavouriteProductModel.fromJson(res);
    } catch (e) {
      return FavouriteProductModel(message: "Error occurred: $e");
    }
  }

  static Future<AddFavouriteProductModel> addFavourite({
    required String productId,
    required String userId,
  }) async {
    try {
      final res = await apiService.postApi(AddFavourite, {
        "userId": userId,
        "productId": productId,
      });
      return AddFavouriteProductModel.fromJson(res);
    } catch (e) {
      return AddFavouriteProductModel(message: "Error occurred: $e");
    }
  }

  static Future<Map<String, dynamic>> removeFavourite({
    required String productId,
    required String userId,
  }) async {
    try {
      final fullUrl = "$deleteFavourite/$userId/$productId";
      final res = await apiService.deleteApi(fullUrl);
      return res;
    } catch (e) {
      return {"error": e.toString()};
    }
  }
}
