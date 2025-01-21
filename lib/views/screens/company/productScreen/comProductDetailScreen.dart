import 'package:brand/barrelView/barrelView.dart';

class ProductDetailScreen extends StatelessWidget {
  final CompanyProduct product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ComProductDetailController(),
      builder: (context, child) {
        final productController =
            Provider.of<ProductController>(context, listen: false);

        return Scaffold(
          appBar: AppBar(
            title: Text(product.name),
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == "Edit") {
                    _editProduct(context, product, productController);
                  } else if (value == "Delete") {
                    _deleteProduct(context, product, productController);
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
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                product.images.isNotEmpty
                    ? Consumer<ComProductDetailController>(
                        builder: (context, imageProvider, child) {
                          return Stack(
                            children: [
                              SizedBox(
                                height: 200,
                                child: PageView.builder(
                                  controller: imageProvider.pageController,
                                  itemCount: product.images.length,
                                  onPageChanged: (index) {
                                    imageProvider.setImageIndex(index);
                                  },
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                FullScreenImageViewer(
                                              images: product.images,
                                              initialIndex: index,
                                            ),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.file(
                                          File(product.images[index]),
                                          fit: BoxFit.contain,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Center(
                                              child: Text(
                                                "Error loading image",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              if (imageProvider.currentIndex > 0)
                                Positioned(
                                  top: 80,
                                  left: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      imageProvider.goToPreviousImage();
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.black54,
                                      child: Icon(Icons.arrow_back,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              if (imageProvider.currentIndex <
                                  product.images.length - 1)
                                Positioned(
                                  top: 80,
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      imageProvider
                                          .goToNextImage(product.images.length);
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.black54,
                                      child: Icon(Icons.arrow_forward,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      )
                    : const Center(
                        child: Text("No images available"),
                      ),
                const SizedBox(height: 16),
                const Text(
                  "Description:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(product.description),
                const SizedBox(height: 16),
                Text(
                  "Price: \$${product.price}",
                  style: const TextStyle(fontSize: 16),
                ),
                if (product.discountPrice != null)
                  Text(
                    "Discount: ${product.discountPrice}%",
                    style: const TextStyle(fontSize: 16, color: Colors.green),
                  ),
                const SizedBox(height: 16),
                Text(
                  "Stock: ${product.stock}",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Method to handle product editing
  void _editProduct(BuildContext context, CompanyProduct product,
      ProductController productController) {
    final nameController = TextEditingController(text: product.name);
    final descriptionController =
        TextEditingController(text: product.description);
    final priceController =
        TextEditingController(text: product.price.toString());
    final stockController =
        TextEditingController(text: product.stock.toString());
    final discountController = TextEditingController(
      text:
          product.discountPrice != null ? product.discountPrice.toString() : "",
    );

    showDialog(
      context: context,
      builder: (context) {
        final height = MediaQuery.of(context).size.height * 1;
        // final width = MediaQuery.of(context).size.width * 1;
        return AlertDialog(
          title: const Text("Edit Product"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height * .02),
                CustomTextField(
                  controller: nameController,
                  labelText: "Product Name",
                ),
                SizedBox(height: height * .02),
                CustomTextField(
                  controller: descriptionController,
                  labelText: "Product Description",
                ),
                SizedBox(height: height * .02),
                CustomTextField(
                  controller: priceController,
                  labelText: "Price",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: height * .02),
                CustomTextField(
                  controller: stockController,
                  labelText: "Stock",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: height * .02),
                CustomTextField(
                  controller: discountController,
                  labelText: "Discount (Optional)",
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog without saving
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                productController.updateProduct(
                  product.copyWith(
                    name: nameController.text,
                    description: descriptionController.text,
                    price:
                        double.tryParse(priceController.text) ?? product.price,
                    stock: int.tryParse(stockController.text) ?? product.stock,
                    discountPrice: discountController.text.isNotEmpty
                        ? double.tryParse(discountController.text)
                        : null,
                  ),
                );
                Navigator.pop(context); // Close the dialog after saving
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  // Method to handle product deletion
  void _deleteProduct(BuildContext context, CompanyProduct product,
      ProductController productController) {
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
