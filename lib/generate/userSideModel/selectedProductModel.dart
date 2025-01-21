import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/utiles/appHelpers.dart';
import 'package:brand/views/screens/user/navBarItems/explore/products/orderFormSelectedprod.dart';

/// Product Model (MODEL)
class Product extends StatelessWidget {
  final List<String> images; // List of image URLs
  final String name; // Product name
  final String shortDetails;
  String? longDetails; // Product short details
  final String color; // Product color
  int quantity;

  Product({
    super.key,
    this.longDetails,
    required this.images,
    required this.name,
    required this.shortDetails,
    required this.color,
    this.quantity = 1,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final productProvider = Provider.of<ProductDetailController>(context);
    final product = productProvider.selectedProduct;
    final favorites = productProvider.listSelectedProduct;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            SizedBox(
              height: 200, // Height of the image carousel
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length, // Number of images
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        images[index], scale: 1, // Image URL
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                              child: Icon(Icons.error, color: Colors.red));
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            // Product Name
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            // Product Details
            Text(
              shortDetails,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8.0),
            // Product Color
            Text(
              color,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            // Product Color
            Text(
              longDetails ?? 'No additional details available.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            // Product Color
            Text(
              'quantity $quantity',
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            // Buy Now Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  width: width * .3,
                  onTap: () {
                    // Check if a specific product is selected or use the favorites list
                    final selectedProducts =
                        productProvider.selectedProduct != null
                            ? [
                                productProvider.selectedProduct!
                              ] // Wrap the single product in a list
                            : favorites; // Use favorites list

                    AppHelpers.showFullBottomSheet(
                      context,
                      OrderFormSelectedProd(selectedProducts: selectedProducts),
                    );
                  },
                  child: const Text('Buy Now'),
                ),
                CustomButton(
                  width: width * .3,
                  onTap: () {
                    productProvider.addToCart(product!); // Add product to cart
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart!'),
                        duration: const Duration(
                            seconds: 1), // Show SnackBar for 2 seconds
                      ),
                    );
                  },
                  child: const Text('Add to card'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
