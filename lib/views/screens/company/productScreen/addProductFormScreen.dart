import 'package:brand/barrelView/barrelView.dart';

class AddProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Add Product")),
        body: Consumer<ProductFormProvider>(
          builder: (context, formProvider, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formProvider.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      SizedBox(height: height * 0.03),
                      CustomTextField(
                        controller: formProvider.nameController,
                        labelText: "Product Name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a product name";
                          }
                          return null;
                        },
                      ),

                      // Product Description
                      SizedBox(height: height * 0.03),
                      CustomTextField(
                        controller: formProvider.descriptionController,
                        labelText: "Product Description",
                      ),

                      // Price
                      SizedBox(height: height * 0.03),
                      CustomTextField(
                        controller: formProvider.priceController,
                        labelText: "Price",
                        keyboardType: TextInputType.number,
                      ),

                      // Stock
                      SizedBox(height: height * 0.03),
                      CustomTextField(
                        controller: formProvider.stockController,
                        labelText: "Stock",
                        keyboardType: TextInputType.number,
                      ),

                      // Discount (Optional)
                      SizedBox(height: height * 0.03),
                      CustomTextField(
                        controller: formProvider.discountController,
                        labelText: "Discount (Optional)",
                        keyboardType: TextInputType.number,
                      ),

                      // Product Category
                      SizedBox(height: height * 0.03),
                      DropdownButtonFormField(
                        value: formProvider.selectedCategory,
                        items: ["Hoodies", "Dryfit", "Pants", "Drop Shoulder"]
                            .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                ))
                            .toList(),
                        onChanged: (value) {
                          formProvider.setCategory(value as String);
                        },
                        decoration: const InputDecoration(
                          labelText: "Product Category",
                        ),
                      ),

                      // Upload Image
                      SizedBox(height: height * 0.03),
                      CustomButton(
                        onTap: formProvider.pickImage,
                        child: const Text("Upload Image"),
                      ),

                      // Display Selected Images
                      if (formProvider.images.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: formProvider.images
                                .map((image) => Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        // Image Preview
                                        Image.file(
                                          File(image),
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        // Cross Icon for Deletion
                                        Positioned(
                                          top: -10,
                                          left: -10,
                                          child: GestureDetector(
                                            onTap: () {
                                              formProvider.removeImage(image);
                                            },
                                            child: CircleAvatar(
                                              radius: 12,
                                              backgroundColor:
                                                  Colors.grey.shade500,
                                              child: const Icon(
                                                Icons.close,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ))
                                .toList(),
                          ),
                        ),

                      // Save Product Button
                      SizedBox(height: height * 0.03),
                      CustomButton(
                        onTap: () {
                          if (formProvider.validateForm()) {
                            final newProduct = formProvider.saveProduct();
                            Provider.of<ProductController>(context,
                                    listen: false)
                                .addProduct(newProduct);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Save Product"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
