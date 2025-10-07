import 'dart:convert';
import 'package:brand/generate/userSideModel/orderCreateModel.dart';
import 'package:brand/view_model/Repository/UserRepository/orderCreateRepository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateOrderController with ChangeNotifier {
  bool isLoading = false;

  // Form controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Quantity
  int quantity = 1;
  void increaseQty() {
    quantity++;
    notifyListeners();
  }

  void decreaseQty() {
    if (quantity > 1) quantity--;
    notifyListeners();
  }

  // Create Order
  Future<OrderCreateModel?> createOrder({
    required String userId,
    required String productId,
    required String productName,
    required String productImage,
    required String productDescription,
    required BuildContext context,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      // ✅ Product JSON without _id
      final productOrder = {
        "product": productId,
        "quantity": quantity,
      };

      final result = await OrderCreateRepository.createOrder(
        userId: userId,
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        city: cityController.text,
        postalCode: postalCodeController.text,
        address: addressController.text,
        products: [productOrder],
      );

      isLoading = false;
      notifyListeners();

      if (result != null && result.message != null) {
        // ✅ Save order summary
        final prefs = await SharedPreferences.getInstance();
        final orderSummary = {
          "productName": productName,
          "productImage": productImage,
          "productDescription": productDescription,
          "quantity": quantity.toString(),
          "price": result.order?.products?.first.quantity.toString(),
        };
        await prefs.setString("last_order", jsonEncode(orderSummary));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.message!)),
        );
      }

      return result;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print("❌ Error in OrderController: $e");
      return null;
    }
  }

  // Validation
  String? validateName(String? value) =>
      value == null || value.isEmpty ? 'Please enter your name' : null;
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your phone number';
    if (!RegExp(r'^(03|04|05)[0-9]{9}$').hasMatch(value)) {
      return 'Enter a valid Pakistani phone number';
    }
    return null;
  }

  String? validateCity(String? value) =>
      value == null || value.isEmpty ? 'Please enter your city' : null;
  String? validatePostalCode(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your postal code';
    if (!RegExp(r'^\d{5}$').hasMatch(value)) {
      return 'Enter a valid postal code';
    }
    return null;
  }

  String? validateHomeAddress(String? value) =>
      value == null || value.isEmpty ? 'Please enter your home address' : null;
}
