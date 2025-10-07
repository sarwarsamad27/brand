import 'package:brand/resources/appColor.dart';
import 'package:brand/view_model/Controller/companySideController/comProductController.dart';
import 'package:brand/views/screens/company/productScreen/comProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brand/view_model/Controller/companySideController/comEntryProductShowController.dart';
import 'package:brand/generate/companySideModels/comEntryProductShowModel.dart';
import 'package:brand/views/widget/customSearchBar.dart';
import 'package:brand/views/screens/company/productScreen/ProductEntryScreen.dart';

class ComEntryProductShowScreen extends StatelessWidget {
  final String userId;
  const ComEntryProductShowScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final productController =
        Provider.of<ComEntryProductShowController>(context);

    // ✅ Screen load hote hi API call
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.fetchProducts(userId);
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8), // light background
        appBar: AppBar(
          title: const Text(
            "📦 My Products",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 1,
            ),
          ),
          elevation: 4,
          shadowColor: Colors.black26,
          centerTitle: true,
          backgroundColor: AppColor.primaryColor,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomSearchbar(
                hintText: "🔍 Search product...",
                prefixicon: const Icon(Icons.search),
                suffixicon: const Icon(Icons.clear),
                borderradius: 30,
                onChanged: (value) {
                  productController.filterProducts(value);
                },
              ),
            ),

            // ✅ Product List
            Expanded(
              child: productController.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    )
                  : productController.errorMessage != null
                      ? Center(
                          child: Text(
                            productController.errorMessage!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                        )
                      : productController.products.isEmpty
                          ? const Center(
                              child: Text(
                                "😕 No products found",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(12),
                              itemCount:
                                  productController.filteredProducts.length,
                              itemBuilder: (context, index) {
                                final Product product =
                                    productController.filteredProducts[index];
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              ChangeNotifierProvider(
                                            create: (_) =>
                                                ComProductController()
                                                  ..fetchProducts(
                                                      userId, product.sId!),
                                            child: ComProductsScreen(
                                              userId: userId,
                                              brandId: product.sId!,
                                              product: product,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(12),
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: (product.image != null &&
                                                product.image!.isNotEmpty)
                                            ? Image.network(
                                                product.image!,
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  // Fallback if image fails to load
                                                  return Container(
                                                    width: 60,
                                                    height: 60,
                                                    color: Colors.grey[200],
                                                    child: const Icon(
                                                      Icons.broken_image,
                                                      size: 30,
                                                      color: Colors.grey,
                                                    ),
                                                  );
                                                },
                                              )
                                            : Container(
                                                width: 60,
                                                height: 60,
                                                color: Colors.grey[200],
                                                child: const Icon(
                                                  Icons.image_not_supported,
                                                  size: 30,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                      ),
                                      title: Text(
                                        product.name ?? "No Name",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(
                                          Icons.delete_forever,
                                          color: Colors.redAccent,
                                          size: 28,
                                        ),
                                        onPressed: () {
                                          _deleteProductDialog(context,
                                              productController, product);
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
            ),
          ],
        ),

        // ✅ Add new product
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ComProductEntryScreen(userId: userId),
              ),
            );

            if (result == true) {
              productController.fetchProducts(userId);
            }
          },
          backgroundColor: AppColor.primaryColor,
          icon: const Icon(Icons.add),
          label: const Text(
            "Add Product",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void _deleteProductDialog(BuildContext context,
      ComEntryProductShowController controller, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("🗑 Delete Product"),
        content: const Text(
          "Are you sure you want to delete this product?",
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              controller.deleteProduct(product.sId!);
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
