import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/utiles/appHelpers.dart';
import 'package:brand/view_model/Controller/companySideController/comproductDetailController.dart';
import 'package:brand/views/screens/user/navBarItems/explore/products/orderFormSelectedprod.dart';

class SelectedProductScreen extends StatelessWidget {
  final CompanyProducts product;

  const SelectedProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final productDetailController =
        Provider.of<ComProductDetailController>(context, listen: false);

    return Scaffold(
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
                                        builder: (_) => FullScreenImageViewer(
                                          images: product.images,
                                          initialIndex: index,
                                        ),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.file(
                                      File(product.images[index]),
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Center(
                                          child: Text(
                                            "Error loading image",
                                            style: TextStyle(color: Colors.red),
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
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  width: width * .3,
                  onTap: () {
                    // final selectedProducts = [product];
                    // AppHelpers.showFullBottomSheet(
                    //   context
                    //   // OrderCreateScreen(selectedProducts: selectedProducts),
                    // );
                  },
                  child: const Text('Buy Now'),
                ),
                CustomButton(
                  width: width * .3,
                  onTap: () {
                    productDetailController.addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart!'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
