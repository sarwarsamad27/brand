import 'package:brand/view_model/Repository/UserRepository/myOrderRepository.dart';
import 'package:flutter/material.dart';
import 'package:brand/generate/userSideModel/myOrderModel.dart';

class MyOrdersController with ChangeNotifier {
  MyOrdersModel? myOrders;
  bool isLoading = false;
  String? error;
  bool _fetched = false; // 👈 NEW flag

  Future<void> fetchMyOrders(String userId) async {
    // 👇 Prevent multiple API calls
    if (_fetched && myOrders != null) return;

    try {
      isLoading = true;
      error = null;
      notifyListeners();

      myOrders = await MyOrdersRepository.myOrderFetch(userId);
      _fetched = true; // 👈 set after success
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Optional: Reset when user logs out
  void clearOrders() {
    myOrders = null;
    _fetched = false;
    notifyListeners();
  }
}
