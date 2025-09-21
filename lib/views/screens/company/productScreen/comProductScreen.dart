import 'package:brand/view_model/Controller/companySideController/comProductController.dart';
import 'package:brand/views/screens/company/productScreen/addProductFormScreen.dart';
import 'package:brand/views/screens/company/productScreen/comProductDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:brand/generate/companySideModels/comEntryProductShowModel.dart';
import 'package:provider/provider.dart';

class ComProductsScreen extends StatefulWidget {
  final Product product; // featured product
  final String userId;
  final String brandId;

  const ComProductsScreen({
    super.key,
    required this.product,
    required this.userId,
    required this.brandId,
  });

  @override
  State<ComProductsScreen> createState() => _ComProductsScreenState();
}

class _ComProductsScreenState extends State<ComProductsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ComProductController>(context, listen: false)
          .fetchProducts(widget.userId, widget.brandId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Consumer<ComProductController>(
        builder: (context, controller, child) {
          return CustomScrollView(
            slivers: [
              // 🔹 Collapsing Header
              SliverAppBar(
                expandedHeight: 260,
                pinned: true,
                backgroundColor: Colors.deepPurple,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    widget.product.name ?? "No Name",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          blurRadius: 4,
                          offset: Offset(1, 1),
                        )
                      ],
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      widget.product.image != null &&
                              widget.product.image!.isNotEmpty
                          ? Image.network(
                              widget.product.image!,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.image_not_supported,
                              size: 120, color: Colors.grey),
                      Container(
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
              ),

              // 🔹 Products Grid
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = controller.productList[index];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ComProductDetailScreen(product: product),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Image
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                  child: product.images != null &&
                                          product.images!.isNotEmpty
                                      ? Image.network(
                                          product.images!.first,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        )
                                      : const Icon(Icons.image_not_supported,
                                          size: 80, color: Colors.grey),
                                ),
                              ),

                              // Product Info
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.productName ?? "No Name",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Rs. ${product.price ?? 0}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: controller.productList.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                ),
              ),
            ],
          );
        },
      ),

      // 🔹 Floating Action Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () async {
          final newProduct = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddProductScreen(
                userId: widget.userId,
                brandId: widget.brandId,
              ),
            ),
          );

          if (newProduct != null) {
            Provider.of<ComProductController>(context, listen: false)
                .addProduct(newProduct);
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
