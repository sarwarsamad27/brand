import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/utiles/appHelpers.dart';

class Favouritescreen extends StatelessWidget {
  const Favouritescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductDetailController>(context);
    final favorites = productProvider.cart; // Assuming 'cart' holds favorites

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite"),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                "Your favourites list is empty!",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Column(
              children: [
                // List of Favorites
                Expanded(
                  child: ListView.builder(
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final product = favorites[index];
                      return ListTile(
                        leading: SizedBox(
                          width: 50, // Set fixed width for the image
                          height: 50, // Set fixed height for the image
                          child: Image.network(
                            product.images[0],
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image, size: 50);
                            },
                          ),
                        ),
                        title: Text(product.name),
                        subtitle: Row(
                          children: [
                            Expanded(
                              child: Text(product.shortDetails),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Quantity: ${product.quantity}', // Show quantity
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            productProvider
                                .removeFromCart(product); // Remove favorite
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${product.name} removed from favourites!'),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                // Conditionally Show "Proceed" Button
                if (favorites.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        onTap: () {
                          AppHelpers.showFullBottomSheet(context,
                              OrderFormScreen(selectedProducts: favorites));
                        },
                        child: const Text("Proceed with favourite product"),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
