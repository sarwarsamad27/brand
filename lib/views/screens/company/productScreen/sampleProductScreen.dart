import 'dart:io';
import 'package:brand/views/screens/company/productScreen/comProductScreen.dart';
import 'package:brand/views/widget/customSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brand/view_model/Controller/companySideController/sampleProductController.dart';
import 'package:brand/generate/companySideMiodels/sampleProductModel.dart';
import 'package:brand/views/screens/company/productScreen/sampleProductFormScreen.dart';

class SampleProductScreen extends StatelessWidget {
  const SampleProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<SampleProductController>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Add Search Bar
            CustomSearchbar(
              suffixicon: const Icon(Icons.search),
              prefixicon: const Icon(Icons.search),
              borderradius: 20,
              hintText: "Search here...",
              onChanged: (value) {
                productController.filterProducts(value);
              },
            ),
            // Product List
            Expanded(
              child: productController.products.isEmpty
                  ? const Center(
                      child: Text('No products added yet'),
                    )
                  : ListView.builder(
                      itemCount: productController.filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product =
                            productController.filteredProducts[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: ListTile(
                            leading: Image.file(
                              File(product.imageUrl),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            trailing: PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == "Edit") {
                                  _showEditProductDialog(
                                      context, productController, product);
                                } else if (value == "Delete") {
                                  _deleteProduct(
                                      context, product, productController);
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: "Edit",
                                  child: Text("Edit"),
                                ),
                                const PopupMenuItem(
                                  value: "Delete",
                                  child: Text("Delete"),
                                ),
                              ],
                              icon: const Icon(Icons.more_vert),
                            ),
                            title: Text(product.name),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ComProductsScreen(
                                    product: product,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => SampleProductForm()),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showEditProductDialog(BuildContext context,
      SampleProductController productController, SampleProductModel product) {
    productController.setPickedImage(product.imageUrl);
    productController.nameController.text = product.name;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: productController.pickImage,
              child: Container(
                height: 150,
                width: 150,
                color: Colors.grey[300],
                child: productController.pickedImage != null
                    ? Stack(
                        children: [
                          Image.file(
                            productController.pickedImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: productController.removeImage,
                              child: const Icon(Icons.close, color: Colors.red),
                            ),
                          ),
                        ],
                      )
                    : const Icon(Icons.add_a_photo, size: 50),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: productController.nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              productController.editProduct(
                product.id,
                productController.nameController.text,
                productController.pickedImage?.path ?? product.imageUrl,
              );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // Method to handle product deletion
  void _deleteProduct(BuildContext context, SampleProductModel product,
      SampleProductController productController) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Product"),
          content: const Text("Are you sure you want to delete this product?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog without deleting
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                productController.deleteProduct(product.id);
                Navigator.pop(context); // Close the dialog after deleting
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
