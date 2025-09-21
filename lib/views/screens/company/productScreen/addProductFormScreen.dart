import 'dart:io';
import 'package:brand/view_model/Controller/companySideController/addProductController.dart';
import 'package:brand/view_model/Controller/companySideController/comProductController.dart';
import 'package:brand/views/widget/customButton.dart';
import 'package:brand/views/widget/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatelessWidget {
  final String userId;
  final String brandId;

  const AddProductScreen({
    super.key,
    required this.userId,
    required this.brandId,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (_) => CreateProductController(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Add Product")),
        body: Consumer<CreateProductController>(
          builder: (context, formProvider, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ Product Name
                    SizedBox(height: height * 0.02),
                    CustomTextField(
                      controller: formProvider.nameController,
                      labelText: "Product Name",
                    ),

                    // ✅ Product Description
                    SizedBox(height: height * 0.02),
                    CustomTextField(
                      controller: formProvider.descriptionController,
                      labelText: "Product Description",
                    ),

                    // ✅ Price
                    SizedBox(height: height * 0.02),
                    CustomTextField(
                      controller: formProvider.priceController,
                      labelText: "Price",
                      keyboardType: TextInputType.number,
                    ),

                    // ✅ Stock
                    SizedBox(height: height * 0.02),
                    CustomTextField(
                      controller: formProvider.stockController,
                      labelText: "Stock",
                      keyboardType: TextInputType.number,
                    ),

                    // ✅ Discount
                    SizedBox(height: height * 0.02),
                    CustomTextField(
                      controller: formProvider.discountController,
                      labelText: "Discount",
                      keyboardType: TextInputType.number,
                    ),

                    // ✅ Category as Colors
                    SizedBox(height: height * 0.02),
                    DropdownButtonFormField(
                      value: formProvider.selectedCategory,
                      items: ["Red", "Blue", "Black", "White", "Green"]
                          .map((color) => DropdownMenuItem(
                                value: color,
                                child: Text(color),
                              ))
                          .toList(),
                      onChanged: (value) {
                        formProvider.setCategory(value as String);
                      },
                      decoration: const InputDecoration(
                        labelText: "Product Color",
                      ),
                    ),

                    // ✅ Upload Image
                    SizedBox(height: height * 0.02),
                    CustomButton(
                      onTap: formProvider.pickImage,
                      child: const Text("Upload Image"),
                    ),

                    if (formProvider.images.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: formProvider.images
                            .map((image) => Stack(
                                  children: [
                                    Image.file(
                                      File(image),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      top: -10,
                                      left: -10,
                                      child: GestureDetector(
                                        onTap: () {
                                          formProvider.removeImage(image);
                                        },
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.red,
                                          child: const Icon(Icons.close,
                                              size: 16, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                            .toList(),
                      ),

                    // ✅ Save Product Button
                    SizedBox(height: height * 0.03),
                    formProvider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            onTap: () async {
                              await formProvider.createProduct(
                                userId: userId,
                                brandId: brandId,
                              );

                              if (formProvider.errorMessage != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text(formProvider.errorMessage!)),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "✅ Product created successfully")),
                                );

                                // ✅ Product list refresh karo
                                final productController =
                                    context.read<ComProductController>();
                                await productController.fetchProducts(
                                    userId, brandId);

                                Navigator.pop(
                                    context, formProvider.response?.product);
                              }
                            },
                            child: const Text("Save Product"),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
