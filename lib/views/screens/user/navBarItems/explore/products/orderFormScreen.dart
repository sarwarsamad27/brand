import 'package:brand/view_model/Controller/companySideController/comOrderController.dart';
import 'package:brand/views/widget/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteOrderFormScreen extends StatelessWidget {
  final List<Map<String, dynamic>> selectedProducts;

  const FavouriteOrderFormScreen({super.key, required this.selectedProducts});

  @override
  Widget build(BuildContext context) {
    final orderController = Provider.of<CreateOrderController>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: modernAppBar(
          context,
          name: "Your Selected Products",
          detail: 'Review products & complete your order',
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Selected Products with Qty Controls
                if (selectedProducts.isNotEmpty) ...[
                  const Text(
                    "Selected Products",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: selectedProducts.length,
                    itemBuilder: (context, index) {
                      final product = selectedProducts[index];
                      final price = product["price"] ?? 0;
                      final quantity = product["quantity"] ?? 1;
                      final total = price * quantity;

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ✅ Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: (product["image"] != "")
                                  ? Image.network(
                                      product["image"],
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                          size: 40),
                                    )
                                  : Container(
                                      width: 70,
                                      height: 70,
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.image,
                                          size: 40, color: Colors.white),
                                    ),
                            ),

                            const SizedBox(width: 14),

                            // ✅ Product Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product["name"],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "Rs. $total",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove_circle,
                                            color: Colors.red),
                                        onPressed: () {
                                          if (product["quantity"] > 1) {
                                            product["quantity"]--;
                                            (context as Element)
                                                .markNeedsBuild();
                                          }
                                        },
                                      ),
                                      Text("${product["quantity"]}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      IconButton(
                                        icon: const Icon(Icons.add_circle,
                                            color: Colors.green),
                                        onPressed: () {
                                          product["quantity"]++;
                                          (context as Element).markNeedsBuild();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const Divider(height: 30),
                ],

                // ✅ Order Form Title
                const Text(
                  "Customer Details",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                const SizedBox(height: 16),

                // ✅ Name Field
                _buildTextField(
                  controller: orderController.nameController,
                  label: "Full Name",
                  icon: Icons.person,
                ),
                const SizedBox(height: 14),

                // ✅ Email Field
                _buildTextField(
                  controller: orderController.emailController,
                  label: "Email",
                  icon: Icons.email,
                ),
                const SizedBox(height: 14),

                // ✅ Phone Field
                _buildTextField(
                  controller: orderController.phoneController,
                  label: "Phone Number",
                  icon: Icons.phone,
                ),
                const SizedBox(height: 14),

                // ✅ City Field
                _buildTextField(
                  controller: orderController.cityController,
                  label: "City",
                  icon: Icons.location_city,
                ),
                const SizedBox(height: 14),

                // ✅ Postal Code Field
                _buildTextField(
                  controller: orderController.postalCodeController,
                  label: "Postal Code",
                  icon: Icons.local_post_office,
                ),
                const SizedBox(height: 14),

                // ✅ Address Field
                _buildTextField(
                  controller: orderController.addressController,
                  label: "Full Address",
                  icon: Icons.home,
                  maxLines: 2,
                ),
                const SizedBox(height: 24),

                // ✅ Place Order Button
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(
                      colors: [Colors.black, Colors.grey],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      for (var product in selectedProducts) {
                        orderController.createOrder(
                          userId: "USER_ID",
                          productId: product["id"],
                          productName: product["name"],
                          productImage: product["image"],
                          productDescription: "",
                          context: context,
                        );
                      }
                    },
                    child: const Text(
                      "Place Order",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Custom TextField
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.black87),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
