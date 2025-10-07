import 'dart:convert';

import 'package:brand/generate/userSideModel/orderCreateModel.dart';
import 'package:brand/generate/userSideModel/productShowModel.dart';
import 'package:brand/view_model/Controller/companySideController/comOrderController.dart';
import 'package:brand/views/widget/customAppbar.dart';
import 'package:brand/views/widget/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderCreateScreen extends StatelessWidget {
  final Products selectedProduct;

  const OrderCreateScreen({super.key, required this.selectedProduct});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateOrderController(),
      child: Consumer<CreateOrderController>(
        builder: (context, orderController, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.grey[100],
              appBar: modernAppBar(
                context,
                name: 'Order Product',
                detail: 'Fill form correctly',
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Product Card
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // ✅ Image Handling
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: (selectedProduct.images != null &&
                                      selectedProduct.images!.isNotEmpty)
                                  ? Image.network(
                                      selectedProduct.images!.first,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.shopping_bag,
                                                  size: 60, color: Colors.grey),
                                    )
                                  : const Icon(Icons.shopping_bag,
                                      size: 60, color: Colors.grey),
                            ),
                            const SizedBox(width: 16),

                            // ✅ Product Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectedProduct.productName ?? "No Name",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "Rs. ${selectedProduct.price ?? 0}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),

                                  // ✅ Quantity Controls
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                            Icons.remove_circle_outline),
                                        onPressed: () =>
                                            orderController.decreaseQty(),
                                      ),
                                      Text(
                                        "${orderController.quantity}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                            Icons.add_circle_outline),
                                        onPressed: () =>
                                            orderController.increaseQty(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🔹 Form Fields
                    CustomTextField(
                      controller: orderController.nameController,
                      hintText: 'Full Name',
                      prefixIcon: const Icon(Icons.person),
                      validator: orderController.validateName,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: orderController.emailController,
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      validator: orderController.validateEmail,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: orderController.phoneController,
                      hintText: 'Phone',
                      prefixIcon: const Icon(Icons.phone),
                      validator: orderController.validatePhone,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: orderController.cityController,
                      hintText: 'City',
                      prefixIcon: const Icon(Icons.location_city),
                      validator: orderController.validateCity,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: orderController.postalCodeController,
                      hintText: 'Postal Code',
                      prefixIcon: const Icon(Icons.local_post_office),
                      validator: orderController.validatePostalCode,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: orderController.addressController,
                      hintText: 'Home Address',
                      prefixIcon: const Icon(Icons.home),
                      validator: orderController.validateHomeAddress,
                    ),

                    const SizedBox(height: 30),

                    // 🔹 Place Order Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          final userId = prefs.getString("id") ?? "";

                          final productOrder = Product(
                            product: selectedProduct.sId ?? "",
                            quantity: orderController.quantity,
                          );

                          print("📦 Order Product: ${productOrder.toJson()}");
                          print(jsonEncode(productOrder.toJson()));

                          final order = await orderController.createOrder(
                            userId: userId,
                            productId: selectedProduct.sId ?? "",
                            productName:
                                selectedProduct.productName ?? "No Name",
                            productImage:
                                selectedProduct.images?.isNotEmpty == true
                                    ? selectedProduct.images!.first
                                    : "",
                            productDescription:
                                selectedProduct.productDescription ?? "",
                            context: context,
                          );

                          if (order != null && order.message != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(order.message!)),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: orderController.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Place Order",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
