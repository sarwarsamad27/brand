import 'package:flutter/material.dart';
import 'package:brand/view_model/Repository/UserRepository/favouriteProductRepository.dart';
import 'package:brand/generate/userSideModel/favouriteProductModel.dart';

class FavouriteController with ChangeNotifier {
  bool isLoading = false;
  List<Favourites> favourites = [];

  Future<void> loadFavourites(String userId) async {
    try {
      isLoading = true;
      notifyListeners();

      final data = await FavouriteProductRepository.fetchFavourites(userId);
      favourites = data.favourites ?? [];

      for (var fav in favourites) {
        fav.quantity = fav.quantity <= 0 ? 1 : fav.quantity;
      }
    } catch (e) {
      debugPrint("❌ Error in loadFavourites: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToFavourites({
    required String userId,
    required String productId,
    required BuildContext context,
  }) async {
    final res = await FavouriteProductRepository.addFavourite(
      userId: userId,
      productId: productId,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(res.message ?? "Added to favourites!")),
    );

    await loadFavourites(userId);
  }

  Future<void> removeFromFavourites({
    required String userId,
    required String productId,
    required BuildContext context,
  }) async {
    final res = await FavouriteProductRepository.removeFavourite(
      userId: userId,
      productId: productId,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(res["message"] ?? res["error"] ?? "Removed!")),
    );

    await loadFavourites(userId);
  }

  /// ✅ Quantity update
  void updateQuantity(Favourites fav, int newQuantity) {
    if (newQuantity < 1) return;
    final idx = favourites.indexWhere((f) => f.sId == fav.sId);
    if (idx != -1) {
      favourites[idx].quantity = newQuantity;
      notifyListeners();
    }
  }

  /// ✅ Total amount
  double get totalAmount {
    double total = 0;
    for (var fav in favourites) {
      final price = fav.product?.price ?? 0;
      total += price * fav.quantity;
    }
    return total;
  }
}
