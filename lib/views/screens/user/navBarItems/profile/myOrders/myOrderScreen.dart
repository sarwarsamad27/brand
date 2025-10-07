import 'package:brand/generate/userSideModel/myOrderModel.dart';
import 'package:brand/view_model/Controller/userSideController.dart/myOrderController.dart';
import 'package:brand/views/screens/user/navBarItems/profile/myOrders/orderdetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final savedId = prefs.getString("id");

    if (savedId != null && savedId.isNotEmpty) {
      setState(() {
        userId = savedId;
      });

      // 👇 call API
      Provider.of<MyOrdersController>(context, listen: false)
          .fetchMyOrders(savedId);
    } else {
      print("❌ No userId found in SharedPreferences");
    }
  }

  // 🔹 Status color mapping
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "for verify":
        return Colors.amber.shade300; // light yellow
      case "verified":
        return Colors.blue.shade400; // blue
      case "delivered":
        return Colors.green.shade400; // green
      case "received":
        return Colors.deepPurple.shade400; // purple
      default:
        return Colors.red.shade300; // fallback for unknown
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MyOrdersController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        backgroundColor: Colors.deepOrange,
      ),
      body: userId == null
          ? const Center(child: Text("User not logged in"))
          : controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : controller.error != null
                  ? Center(child: Text("❌ ${controller.error}"))
                  : controller.myOrders == null ||
                          controller.myOrders!.orders == null ||
                          controller.myOrders!.orders!.isEmpty
                      ? const Center(child: Text("No orders found"))
                      : ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          cacheExtent: 500, // 👈 preload next items
                          padding: const EdgeInsets.all(12),
                          itemCount: controller.myOrders!.orders!.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final Orders order =
                                controller.myOrders!.orders![index];
                            final product = order.products?.first.product;

                            return InkWell(
                              onTap: () {
                                if (product != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OrderProductDetailScreen(
                                        product: product,
                                        order: order,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Card(
                                margin: EdgeInsets
                                    .zero, // 👈 separator handles spacing
                                elevation:
                                    2, // less elevation = smoother scroll
                                shadowColor: Colors.black12,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Product image
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: (product?.images != null &&
                                                product!.images!.isNotEmpty)
                                            ? Image.network(
                                                product.images!.first,
                                                width: 70,
                                                height: 70,
                                                fit: BoxFit.cover,
                                                errorBuilder: (_, __, ___) =>
                                                    const Icon(
                                                  Icons.shopping_bag,
                                                  size: 60,
                                                  color: Colors.grey,
                                                ),
                                                // 👇 smoother image loading
                                                frameBuilder: (ctx, child,
                                                        frame, wasLoaded) =>
                                                    frame == null
                                                        ? const SizedBox(
                                                            width: 70,
                                                            height: 70,
                                                            child: Center(
                                                                child: CircularProgressIndicator(
                                                                    strokeWidth:
                                                                        2)),
                                                          )
                                                        : child,
                                              )
                                            : const Icon(
                                                Icons.shopping_bag,
                                                size: 60,
                                                color: Colors.grey,
                                              ),
                                      ),
                                      const SizedBox(width: 12),

                                      // Product + Order info
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product?.productName ??
                                                  "No product name",
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "Ordered on: ${order.createdAt?.substring(0, 10)}",
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Order status badge
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(
                                                  order.status ?? "")
                                              .withOpacity(0.15),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: _getStatusColor(
                                                order.status ?? ""),
                                          ),
                                        ),
                                        child: Text(
                                          order.status ?? "Unknown",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: _getStatusColor(
                                                order.status ?? ""),
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
