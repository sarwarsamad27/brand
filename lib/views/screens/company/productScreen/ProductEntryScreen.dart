import 'package:brand/view_model/Controller/companySideController/comProductEntryController.dart';
import 'package:brand/view_model/Controller/companySideController/comProfileController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComProductEntryScreen extends StatelessWidget {
  final String userId;
  const ComProductEntryScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ComProductEntryController(),
        ),
      ],
      child: Consumer2<ComProfileController, ComProductEntryController>(
        builder: (context, profileController, productController, child) {
          return Scaffold(
            appBar: AppBar(title: const Text('Add Product')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Image Picker
                    GestureDetector(
                      onTap: productController.pickImage,
                      child: Container(
                        height: 150,
                        width: double.infinity,
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
                                      child: const Icon(Icons.close,
                                          color: Colors.red),
                                    ),
                                  ),
                                ],
                              )
                            : const Icon(Icons.add_a_photo, size: 50),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Name Field
                    TextField(
                      controller: productController.nameController,
                      decoration:
                          const InputDecoration(labelText: 'Product Name'),
                    ),
                    const SizedBox(height: 20),

                    // Save Button
                    productController.isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              productController.saveProduct(context);
                            },
                            child: const Text('Save Product'),
                          ),

                    // Error / Response
                    if (productController.errorMessage != null)
                      Text(productController.errorMessage!,
                          style: const TextStyle(color: Colors.red)),
                    if (productController.productResponse != null)
                      Text(productController.productResponse!.message ?? "",
                          style: const TextStyle(color: Colors.green)),
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
